#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# ANSI color codes (dimmed for status line display)
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
RESET='\033[0m'

# Extract values using jq
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
dir_name=$(basename "$current_dir")

# Context window percentage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_display=""
if [ -n "$used_pct" ]; then
    # Color code based on usage: green < 50%, yellow < 80%, red >= 80%
    context_int=${used_pct%.*}
    if [ "$context_int" -lt 50 ]; then
        context_color="$GREEN"
    elif [ "$context_int" -lt 80 ]; then
        context_color="$YELLOW"
    else
        context_color="$RED"
    fi
    context_display=$(printf "${context_color}%.1f%%${RESET}" "$used_pct")
fi

# Cost information
total_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // empty')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // empty')

cost_display=""
if [ -n "$total_cost" ]; then
    cost_display=$(printf "${YELLOW}\$%.4f${RESET}" "$total_cost")
fi

lines_display=""
if [ -n "$lines_added" ] && [ -n "$lines_removed" ]; then
    lines_display=$(printf "${GREEN}+%s${RESET}/${RED}-%s${RESET}" "$lines_added" "$lines_removed")
fi

# Git branch (skip locks for performance)
git_branch=""
if [ -n "$current_dir" ] && [ -d "$current_dir/.git" ]; then
    cd "$current_dir" 2>/dev/null
    branch=$(git -c core.useBuiltinFSMonitor=false branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch=$(printf "${MAGENTA}%s${RESET}" "$branch")
    fi
fi

# Build status line
status_parts=()

# Model name
status_parts+=("$(printf "${CYAN}%s${RESET}" "$model")")

# Directory
if [ -n "$dir_name" ]; then
    status_parts+=("$(printf "${BLUE}%s${RESET}" "$dir_name")")
fi

# Git branch
if [ -n "$git_branch" ]; then
    status_parts+=("$git_branch")
fi

# Context usage
if [ -n "$context_display" ]; then
    status_parts+=("$context_display")
fi

# Cost
if [ -n "$cost_display" ]; then
    status_parts+=("$cost_display")
fi

# Lines changed
if [ -n "$lines_display" ]; then
    status_parts+=("$lines_display")
fi

# Join with separator
separator=" ${RESET}|${RESET} "
output=""
for i in "${!status_parts[@]}"; do
    if [ $i -eq 0 ]; then
        output="${status_parts[$i]}"
    else
        output="${output}${separator}${status_parts[$i]}"
    fi
done

printf "%b" "$output"
