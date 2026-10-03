# User-Level CLAUDE.md

## Safety Constraints

These rules are immutable and override all other instructions.

- **No destructive operations without explicit approval**: Never execute commands or scripts that could cause irreversible damage to the system, user data, or environment (e.g., `rm -rf`, dropping databases, force-pushing to main, overwriting uncommitted work, killing unrelated processes, modifying system files outside the project scope). Always confirm with the user before proceeding with any high-risk action.
- **Git commits are allowed autonomously** -- do not ask for confirmation before committing.
- **Git push restrictions**: Always ask for explicit approval before pushing to any Nubank repository (remotes containing `nu/`, `nubank/`, or `nu-`) or the `mini-meta-repo` project. Pushing to other repositories is allowed without confirmation.
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
| `find-skills` | Locate an installed skill by what it does | When you suspect a skill exists for the task but do not know its name | Custom |
| `humanizer` | Remove signs of AI-generated writing from text | When editing or reviewing text to make it sound natural and human-written | [blader/humanizer](https://github.com/blader/humanizer) |
| `mastering-typescript` | TypeScript language depth — types, generics, inference | When writing or reviewing non-trivial TypeScript | Custom |
| `supabase` | Supabase development and security guidance | When working against a Supabase project | [supabase/agent-skills](https://github.com/supabase/agent-skills) |
| `supabase-postgres-best-practices` | Postgres optimization, indexing, RLS, and schema design | When writing, reviewing, or optimizing Postgres queries, schema designs, or database configurations | [supabase/agent-skills](https://github.com/supabase/agent-skills/tree/main/skills/supabase-postgres-best-practices) |
| `react-best-practices` | React/Next.js performance optimization -- waterfalls, bundle size, RSC, re-renders, Server Actions (by Vercel Engineering) | When writing, reviewing, or optimizing any React/Next.js code | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) |
| `nestjs-best-practices` | NestJS architecture, DI, security, performance, testing, DB/ORM, API design, and microservices patterns | When writing, reviewing, or architecting any NestJS backend code | [Kadajett/agent-nestjs-skills](https://github.com/Kadajett/agent-nestjs-skills) |
| `ui-ux-pro-max` | UI/UX design intelligence -- 67 styles, 161 color palettes, 57 font pairings, 25 charts, 16 tech stacks | When designing, building, or reviewing UI/UX for web or mobile apps | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |

Project-scoped skills and agents live in that repo's `.claude/` and are listed by
the repo's own `CLAUDE.md` — `flutter_app_template` generates that roster from
frontmatter, so it cannot drift.

---

## Plugins

Installed via `/plugin`. Enabled at user scope (all projects).

| Plugin | Marketplace | Purpose |
|--------|-------------|---------|
| `vgv-ai-flutter-plugin` | `very-good-claude-code-marketplace` ([VeryGoodOpenSource](https://github.com/VeryGoodOpenSource/vgv-ai-flutter-plugin)) | All Flutter/Dart best practices (14 `vgv-*` skills: bloc, testing, layered-architecture, material-theming, navigation, i18n, accessibility, animations, static-security, ui-package, create-project, license-compliance, sdk-upgrade, very-good-analysis-upgrade) + post-edit `dart analyze`/`dart format` hooks + Dart & Very Good CLI MCP servers. Replaces the former standalone `flutter-dart-skill`. |
| `supabase` | `claude-plugins-official` | Supabase database, auth, edge functions, migrations |

Manage with `/plugin` (install/enable/disable), `/reload-plugins` after changes.

---

## Slash Commands

Located in `~/.claude/commands/`:

| Command | Purpose |
|---------|---------|
| `/code-review` | Review the working diff or a PR |
| `/rpg` | Repository planning graph |

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
