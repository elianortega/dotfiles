#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# ANSI color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
DIM='\033[2m'
RESET='\033[0m'

# -- Directory --
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
dir_name=$(basename "$current_dir")

# -- Model (short) --
# Extract short name (e.g. "Opus") and version from model id (e.g. claude-opus-4-6 -> 4.6)
model_id=$(echo "$input" | jq -r '.model.id // ""')
short_name=$(echo "$model_id" | sed -n 's/claude-\([a-z]*\)-.*/\1/p' | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
model_version=$(echo "$model_id" | grep -o '[0-9]-[0-9]' | head -1 | tr '-' '.')
if [ -n "$short_name" ] && [ -n "$model_version" ]; then
    model_display="$short_name $model_version"
elif [ -n "$short_name" ]; then
    model_display="$short_name"
else
    model_display=$(echo "$input" | jq -r '.model.display_name // "Claude"')
fi

# -- Git branch + dirty status --
git_display=""
if [ -n "$current_dir" ]; then
    cd "$current_dir" 2>/dev/null
    branch=$(git -c core.useBuiltinFSMonitor=false branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        dirty_count=$(git -c core.useBuiltinFSMonitor=false status --porcelain 2>/dev/null | wc -l | tr -d ' ')
        if [ "$dirty_count" -gt 0 ]; then
            git_display=$(printf "${MAGENTA}%s ${RED}✗%s${RESET}" "$branch" "$dirty_count")
        else
            git_display=$(printf "${MAGENTA}%s ${GREEN}✓${RESET}" "$branch")
        fi
    fi
fi

# -- Context usage --
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_display=""
if [ -n "$used_pct" ]; then
    context_int=${used_pct%.*}
    if [ "$context_int" -lt 50 ]; then
        context_color="$GREEN"
    elif [ "$context_int" -lt 80 ]; then
        context_color="$YELLOW"
    else
        context_color="$RED"
    fi
    context_display=$(printf "${context_color}◐ %d%%${RESET}" "$context_int")
fi

# -- Build status line --
status_parts=()

if [ -n "$dir_name" ]; then
    status_parts+=("$(printf "${BLUE}%s${RESET}" "$dir_name")")
fi

status_parts+=("$(printf "${CYAN}%s${RESET}" "$model_display")")

if [ -n "$git_display" ]; then
    status_parts+=("$git_display")
fi

if [ -n "$context_display" ]; then
    status_parts+=("$context_display")
fi

# Join with separator
separator=" ${DIM}|${RESET} "
output=""
for i in "${!status_parts[@]}"; do
    if [ $i -eq 0 ]; then
        output="${status_parts[$i]}"
    else
        output="${output}${separator}${status_parts[$i]}"
    fi
done

printf "%b" "$output"
