# User-Level CLAUDE.md

## Core Philosophy

**Key Principles:**

1. **Plan Before Execute**: Use Plan Mode for complex operations
2. **Delegate**: Use planner agent for complex feature work
3. **Review**: Use code-reviewer agent after writing code
4. **Surface Unknowns**: Every plan must end with an "Open Questions" section listing anything unclear, ambiguous, or needing user input before implementation begins

---

## Modular Rules

Detailed guidelines are in `~/.claude/rules/`:

| Rule File       | Contents                                     |
| --------------- | -------------------------------------------- |
| git-workflow.md | Commit format, PR workflow                   |
| agents.md       | Agent orchestration, when to use which agent |

---

## Available Agents

Located in `~/.claude/agents/`:

| Agent         | Purpose                         |
| ------------- | ------------------------------- |
| planner       | Feature implementation planning |
| code-reviewer | Code review for quality         |

---

## Skills

Located in `~/.claude/skills/`:

| Skill                              | Purpose                                          |
| ---------------------------------- | ------------------------------------------------ |
| humanizer                          | Remove signs of AI-generated writing from text   |
| supabase-postgres-best-practices   | Postgres optimization and best practices         |

---

## Slash Commands

Located in `~/.claude/commands/`:

| Command       | Purpose                                            |
| ------------- | -------------------------------------------------- |
| skill-i       | Install a skill into the current project           |
| skill-i-g     | Install a skill globally (dotfiles, git-tracked)   |
| skill-d       | Remove a skill from the current project            |
| skill-d-g     | Remove a skill from dotfiles (globally tracked)    |

---

## Personal Preferences

### Privacy

- Always redact logs; never paste secrets (API keys/tokens/passwords/JWTs)
- Review output before sharing - remove any sensitive data

### Code Style

- No emojis in code, comments, or documentation
- Many small files over few large files

### Git

- Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`
- Always test locally before committing
- Small, focused commits

---

## Stack

- **Primary**: Flutter / Dart, Typescript
- **Editor**: Cursor

---

## Tools

Preferred CLI tools for common tasks:

| Task | Tool | Notes |
|------|------|-------|
| GitHub (PRs, issues, checks, releases) | `gh` | Always use `gh` CLI, never browser scraping |
| File search | `ripgrep` (`rg`) | Faster than grep |
| Fuzzy finding | `fzf` | Pipe into fzf for interactive selection |
| Directory navigation | `zoxide` | `cd` is aliased to `z` (zoxide); `cdd` is aliased to the real `cd`. Always use `cdd` when navigating directories in Bash commands |

### `gh` Quick Reference

```
gh pr list / gh pr view <number>
gh pr create --title "..." --body "..."
gh pr comment <number> --body "..."
gh api repos/{owner}/{repo}/pulls/<number>/comments
gh issue list / gh issue view <number>
gh pr checks <number>
```
