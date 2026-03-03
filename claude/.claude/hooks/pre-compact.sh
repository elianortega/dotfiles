#!/bin/bash
# Pre-Compact Hook: Save session state before context compression

SESSION_DIR="$HOME/.claude/.tmp"
mkdir -p "$SESSION_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
SESSION_FILE="$SESSION_DIR/session-$TIMESTAMP.md"

# This hook is called before /compact - Claude can write state here
# The actual content would be provided by Claude during the session

echo "# Session State - $TIMESTAMP" > "$SESSION_FILE"
echo "" >> "$SESSION_FILE"
echo "Session state saved at: $SESSION_FILE"
