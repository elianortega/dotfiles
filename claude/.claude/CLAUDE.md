# Working with Elian

Global instructions. They load in every session on this machine, in every
project, so everything here has to be true everywhere. Stack and product
specifics live lower down; see "Where instructions live".

## Safety

These override everything else.

- **Destructive actions need my explicit yes.** Deleting data, dropping
  databases, force-pushing, overwriting uncommitted work, killing processes you
  did not start, changing files outside the project. I run sessions without
  permission prompts on purpose, so this rule is the check.
- **Never deploy unless I asked for that deploy in this conversation.** "Merge"
  does not mean "deploy". A hook blocks production deploy commands (Supabase,
  Shorebird, Wrangler, Firebase, Vercel). When I did ask, prefix the command
  with `CLAUDE_DEPLOY_OK=1` so it passes first time. When I did not, report the
  deploy as pending.
- **Commit and push freely, with one exception.** Commit without asking. Push
  without asking, except to Nubank repositories (the remote contains `nubank`,
  or an org or repo named `nu` or `nu-*`) and `mini-meta-repo`: ask first, then
  prefix the push with `CLAUDE_PUSH_OK=1`. The same hook enforces this.
- **Recurring costs need a yes.** Before building on anything that adds a paid
  service or a monthly bill, state the cost and ask.
- **Changes to `~/.claude` or the dotfiles harness:** say what and why and get
  my approval before applying.
- **Secrets stay out of output.** Redact logs; never print keys, tokens,
  passwords or JWTs. When reading a secret, check it is not a masked value.

## Where instructions live

| Layer  | Location                                                                        | Holds                                  |
| ------ | ------------------------------------------------------------------------------- | -------------------------------------- |
| Global | `~/.claude` (source: `~/dotfiles/claude/.claude`)                               | How to work with me, on any stack      |
| Stack  | monorepo root: `CLAUDE.md`, `.claude/rules`, `.claude/skills`, `.claude/agents` | Rules for that framework and repo      |
| App    | `apps/<app>/CLAUDE.md` and `apps/<app>/.claude`                                 | Product context and product operations |
| Memory | automatic, one per repository, shared by its worktrees                          | Facts and decisions, never rules       |

Put a new instruction at the narrowest layer that covers it, and in that layer
only. Framework, product and client names do not belong in this file; if you
find one here, move it down. Feedback from me that applies to every project
belongs here, not in one repository's memory.

Agents defined inside an app folder are only visible to sessions started in
that app. Skills defined there are visible from the repository root too.

## Pick a lane

Decide which of these the request is before starting. Say which in one line if
it is not obvious.

- **Quick** (a production operation, a small fix, a question): no plan, no
  subagents. If a skill covers it, use the skill.
- **Feature** (one app, up to about a day): plan once, get my approval, build
  in the same session, run one independent reviewer, then ship.
- **Build** (multi-day, an MVP, many items): one planning session writes the
  backlog. After that, one fresh session per item, each starting from the
  project's status file. A build is never one long session.

## Token discipline

Every tool call re-sends the whole conversation, so cost is turns times
context. Measured on my own usage, three quarters of all tokens went to turns
that ran a single shell command.

- **Batch.** Send independent lookups in one message. Chain related shell
  commands in one call. Read a file once with a wide range instead of paging
  through it.
- **Large documents by search.** Backlogs, decision logs and ledgers are read
  with a search and a line range, never whole.
- **Keep noise out.** Send long output (test runs, builds, logs) to a file and
  read the part that matters.
- **Short sessions.** When a work item is done, update the status file and
  stop; the next item gets a fresh session. Prefer a handoff note and a new
  session over compacting a long one.
- **Subagents by role and model.** Spawn one only for independent work or a
  fresh-context check. Name the role and the model: Sonnet for search and
  implementation, Opus for verification and architecture. A subagent with no
  model named runs on Sonnet here.
- **Fan-out needs a yes when I am present.** State how many agents and why
  first. One reviewer per finished item is the standing exception. When I hand
  off a build and leave, proceed without asking.

## Asking me things

- Ask in product terms: what the user of the product can and cannot do under
  each option, and what it costs in days. Keep schema and test names out of
  the question.
- Every plan ends with an "Open questions" section listing whatever needs my
  input before work starts. If there is nothing, say so.
- When a request names several targets (sites, apps, files, brand assets),
  restate the exact list in one line before starting.
- If I answer "make it work" on something with legal or irreversible
  consequences, do the safe half and list the decision as pending.

## Finishing

- End with what is applied and what is only proposed, in plain words.
- For multi-session work, keep the project's status file current: merged,
  deployed, pending for me, next up.
- Report failures as failures, with the output.

## Code

- Layers stay separate: presentation, business logic, data. Dependencies point
  one way.
- Many small files over few large ones. Distinct names, so a search finds one
  thing.
- Comments explain why. No emojis in code, comments, commits or docs.

## Git

- Commit messages: `<type>: <description>`, with types feat, fix, refactor,
  docs, test, chore, perf, ci.
- Pull requests: summarize the whole branch (`git diff <base>...HEAD`), include
  a test plan, push new branches with `-u`.
- Gate merges on the repository's local checks. Do not wait on remote CI unless
  I ask.

## This machine

- Shell is zsh on macOS. Unquoted variables are not word-split, so loop over
  arrays. There is no `timeout` command.
- Use `gh` for GitHub and `rg` for search.
