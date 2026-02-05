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
