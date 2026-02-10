---
allowed-tools: Bash(npx *), Bash(ls *), Bash(mkdir *), Bash(cp *), Bash(rm *), Bash(rmdir *), Bash(stow *), Bash(readlink *)
description: Install a Claude Code skill into dotfiles (globally tracked)
argument-hint: <source> --skill <name> (e.g. davila7/claude-code-templates --skill humanizer)
---

# Install Skill (Dotfiles / Global)

Install a skill globally and move it into the dotfiles repo so it is tracked in git and available on any machine after stowing.

## Arguments

$ARGUMENTS

## Constants

- Dotfiles skills dir: `~/dotfiles/claude/.claude/skills`
- Dotfiles root: `~/dotfiles`

## Steps

Follow these steps exactly:

### 0. Validate arguments

If `$ARGUMENTS` is empty, stop and ask the user for the source and skill name.
Example usage: `/skill-i-g davila7/claude-code-templates --skill humanizer`

### 1. Install the skill globally

```
npx -y skills add $ARGUMENTS -g --agent claude-code -y
```

This downloads the skill and places it at `~/.agents/skills/<name>/` with a symlink at `~/.claude/skills/<name>/`.

### 2. Identify the installed skill name

List `~/.agents/skills/` to find the newly installed skill directory name(s).

### 3. Check for existing skill in dotfiles

If `~/dotfiles/claude/.claude/skills/<skill-name>/` already exists, inform the user that this will overwrite the existing version (update). Proceed unless they object.

### 4. Move the skill into dotfiles

For each installed skill:

```
mkdir -p ~/dotfiles/claude/.claude/skills/<skill-name>
cp -R ~/.agents/skills/<skill-name>/. ~/dotfiles/claude/.claude/skills/<skill-name>/
```

### 5. Clean up installer artifacts

IMPORTANT: Before removing anything, check whether `~/.claude/skills` is already a stow symlink (pointing into `~/dotfiles/...`).

```
readlink ~/.claude/skills
```

- If `~/.claude/skills` is a **symlink pointing into dotfiles**, only remove the agents canonical copy:
  ```
  rm -rf ~/.agents/skills/<skill-name>
  ```
  Do NOT remove anything under `~/.claude/skills/` as it would delete files from the dotfiles repo.

- If `~/.claude/skills/<skill-name>` is a **standalone symlink** (pointing to `~/.agents/skills/...`), remove both:
  ```
  rm -rf ~/.agents/skills/<skill-name>
  rm -rf ~/.claude/skills/<skill-name>
  ```
  Then if `~/.claude/skills/` is now an empty directory, remove it:
  ```
  rmdir ~/.claude/skills 2>/dev/null || true
  ```

### 6. Restow

```
stow -R -d ~/dotfiles -t ~ claude
```

### 7. Verify

- Confirm `~/.claude/skills/<skill-name>/SKILL.md` exists and resolves through stow into the dotfiles repo:
  ```
  ls -la ~/.claude/skills/<skill-name>/SKILL.md
  ```
- Report: skill name, location in dotfiles, and remind the user to commit the new skill to git.
