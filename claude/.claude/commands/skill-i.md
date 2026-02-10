---
allowed-tools: Bash(npx skills *), Bash(ls *)
description: Install a Claude Code skill into the current project
argument-hint: <source> --skill <name> (e.g. davila7/claude-code-templates --skill humanizer)
---

# Install Skill (Project-Local)

Install a skill into the current project's `.claude/skills/` directory.

## Arguments

$ARGUMENTS

## Steps

### 0. Validate arguments

If `$ARGUMENTS` is empty, stop and ask the user for the source and skill name.
Example usage: `/skill-i davila7/claude-code-templates --skill humanizer`

### 1. Install the skill

```
npx -y skills add $ARGUMENTS --agent claude-code -y
```

### 2. Verify

List both `.agents/skills/` and `.claude/skills/` in the current project directory to confirm the skill was installed.

### 3. Report

Report the skill name, installed location, and the files that were created.
