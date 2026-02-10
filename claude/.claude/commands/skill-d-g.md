---
allowed-tools: Bash(ls *), Bash(rm *), Bash(rmdir *), Bash(stow *), Bash(readlink *)
description: Remove a Claude Code skill from dotfiles (globally tracked)
argument-hint: <skill-name> (e.g. humanizer)
---

# Remove Skill (Dotfiles / Global)

Remove a skill from the dotfiles repo and restow so it is no longer available globally.

## Arguments

$ARGUMENTS

## Constants

- Dotfiles skills dir: `~/dotfiles/claude/.claude/skills`
- Dotfiles root: `~/dotfiles`

## Steps

### 0. Validate arguments

If `$ARGUMENTS` is empty, list the skills in `~/dotfiles/claude/.claude/skills/` and ask the user which one to remove.

### 1. Confirm with the user

Show the skill name and its SKILL.md location. Ask the user to confirm deletion before proceeding.

### 2. Remove from dotfiles

```
rm -rf ~/dotfiles/claude/.claude/skills/<skill-name>
```

Clean up empty parent directory:
```
rmdir ~/dotfiles/claude/.claude/skills 2>/dev/null || true
```

### 3. Clean up any leftover global artifacts

If `~/.agents/skills/<skill-name>` exists, remove it:
```
rm -rf ~/.agents/skills/<skill-name>
```

### 4. Restow

```
stow -R -d ~/dotfiles -t ~ claude
```

### 5. Verify

- Confirm `~/.claude/skills/<skill-name>` no longer exists.
- Report what was removed and remind the user to commit the deletion to git.
