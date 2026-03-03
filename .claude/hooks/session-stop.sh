#!/bin/bash
# Session Stop Hook: Persist learnings at session end

LEARNINGS_DIR="$HOME/.claude/.tmp/learnings"
mkdir -p "$LEARNINGS_DIR"

TIMESTAMP=$(date +"%Y-%m-%d")
LEARNINGS_FILE="$LEARNINGS_DIR/learnings-$TIMESTAMP.md"

# Append session end marker
echo "" >> "$LEARNINGS_FILE"
echo "---" >> "$LEARNINGS_FILE"
echo "Session ended: $(date +"%Y-%m-%d %H:%M:%S")" >> "$LEARNINGS_FILE"
