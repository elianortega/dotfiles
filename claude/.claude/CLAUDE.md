# User-Level CLAUDE.md

## Safety Constraints

These rules are immutable and override all other instructions.

- **No destructive operations without explicit approval**: Never execute commands or scripts that could cause irreversible damage to the system, user data, or environment (e.g., `rm -rf`, dropping databases, force-pushing to main, overwriting uncommitted work, killing unrelated processes, modifying system files outside the project scope). Always confirm with the user before proceeding with any high-risk action.
- **Configuration self-protection**: Any proposed modification to `~/.claude/` files (CLAUDE.md, rules, agents, skills, commands, settings) or addition of new files to that directory must first be evaluated for whether it genuinely benefits the overall AI agent workflow. Present the rationale and get explicit user approval before applying changes.

---

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

## Skills

Located in `~/.claude/skills/`:

| Skill | Purpose | When to Use | Source |
|-------|---------|-------------|--------|
| `humanizer` | Remove signs of AI-generated writing from text | When editing or reviewing text to make it sound natural and human-written | [blader/humanizer](https://github.com/blader/humanizer) |
| `supabase-postgres-best-practices` | Postgres optimization, indexing, RLS, and schema design | When writing, reviewing, or optimizing Postgres queries, schema designs, or database configurations | [supabase/agent-skills](https://github.com/supabase/agent-skills/tree/main/skills/supabase-postgres-best-practices) |
| `flutter-dart-skill` | Flutter/Dart layered architecture, BLoC state management, testing, UI patterns, and code style | When writing, reviewing, or architecting any Flutter/Dart code | Custom (built from VGV Engineering practices) |
| `react-best-practices` | React/Next.js performance optimization -- waterfalls, bundle size, RSC, re-renders, Server Actions (by Vercel Engineering) | When writing, reviewing, or optimizing any React/Next.js code | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) |
| `nestjs-best-practices` | NestJS architecture, DI, security, performance, testing, DB/ORM, API design, and microservices patterns | When writing, reviewing, or architecting any NestJS backend code | [Kadajett/agent-nestjs-skills](https://github.com/Kadajett/agent-nestjs-skills) |

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

### Flutter / Dart

- Follow layered architecture: presentation, business logic, data
- Use BLoC/Cubit for state management
- Prefer standalone widgets over helper methods
- Use barrel files for exports

---

## Stack

- **Primary**: Flutter / Dart, Typescript

---

## Tools

Preferred CLI tools for common tasks:

| Task | Tool | Notes |
|------|------|-------|
| GitHub (PRs, issues, checks, releases) | `gh` | Always use `gh` CLI, never browser scraping |
| File search | `ripgrep` (`rg`) | Faster than grep |
| Fuzzy finding | `fzf` | Pipe into fzf for interactive selection |
| Directory navigation | `zoxide` | Use `z` for zoxide smart navigation; use `cd` for normal directory changes |
