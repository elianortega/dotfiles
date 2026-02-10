---
allowed-tools: Bash(ls *), Bash(rm *), Bash(rmdir *)
description: Remove a Claude Code skill from the current project
argument-hint: <skill-name> (e.g. humanizer)
---

# Remove Skill (Project-Local)

Remove a skill from the current project.

## Arguments

$ARGUMENTS

## Steps

### 0. Validate arguments

If `$ARGUMENTS` is empty, list the skills in `.claude/skills/` and `.agents/skills/` in the current project and ask the user which one to remove.

### 1. Confirm with the user

Show the skill name and ask the user to confirm deletion before proceeding.

### 2. Remove the skill

```
rm -rf .claude/skills/<skill-name>
rm -rf .agents/skills/<skill-name>
```

Clean up empty parent directories:
```
rmdir .claude/skills 2>/dev/null || true
rmdir .agents/skills 2>/dev/null || true
```

### 3. Verify

List `.claude/skills/` to confirm the skill is gone. Report what was removed.
