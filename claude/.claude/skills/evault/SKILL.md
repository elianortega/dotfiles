---
name: evault
description: |
  Back up, document, find and restore development secrets with the evault CLI:
  API keys, tokens, passwords, database URLs, .env values, signing keystores,
  Apple .p8 keys, service-account JSON, any credential file. Use whenever a
  secret is created, received, rotated or referenced in a project ("save this
  token", "add the key to .env", "new keystore"), when a local copy is missing
  ("set up .env.local on this worktree", "where is the upload keystore", "what
  was the value of"), when a secret was exposed, and to audit what needs rotating.
---

# evault

evault is the global backup of every development secret: one encrypted folder
per project (`evault path`, normally `~/evault`), each item documented in that
project's README, pushed to a private repo. Format reference: `docs/format.md`
in the CLI repo (`$(dirname $(dirname $(readlink -f $(command -v evault))))/docs/format.md`).

## The model: local copy for work, evault for backup

- Each project keeps its own working copy wherever it reads it: `.env.local`,
  `android/key.properties`, the keystore in `android/app/`, a key file in a
  gitignored folder. Builds, scripts and sessions read that local copy.
- evault holds a backup of the same value, plus the context: what it is,
  where the copies live, when it expires, how to replace it.
- Do not read from evault while a local copy exists. Reading needs Touch ID,
  and the local copy is what the project uses.
- Read from evault only to restore a missing local copy (new machine, fresh
  worktree, deleted file), then work from the restored copy.

## When a secret appears in a project (new, received, or rotated)

Do all three, in this order:

1. **Local copy**: put it where the project reads it (the gitignored env file,
   key.properties, the key file path the config expects). Never commit it.
2. **Backup**: save the same value to evault.
   ```sh
   evault set <project> <ENV_NAME>                     # user copied it: reads the clipboard, clears it
   <command printing the value> | evault set <project> <ENV_NAME> --stdin   # value you generated
   evault add <project> <path> [--name <file-name>]    # a file (keystore, .p8, JSON key)
   evault import <project> <env-file>                  # every KEY=value of a local env file
   ```
   Use the exact env var name the project reads. Replacing a value needs `--force`.
   If the project already has secrets that are not in evault, back them up too:
   `evault compare <project> <env-file>` shows what is missing.
3. **Document** every field of the new item. Saving creates TODO fields:
   ```sh
   evault meta <project> <name> what "Cloudflare R2 token for the media bucket"
   evault meta <project> <name> used-in "apps/web/.env.local; Vercel env (production)"   # every copy
   evault meta <project> <name> created 2026-10-16
   evault meta <project> <name> expires never            # or YYYY-MM-DD
   evault meta <project> <name> scope "R2 read+write, bucket media only"
   evault meta <project> <name> recoverable "no: shown once at creation"
   evault meta <project> <name> rotate "Cloudflare > R2 > API tokens > roll; update Vercel env"
   evault meta <project> <name> status ok                # ok | rotate | exposed | revoked
   evault meta <project> <name> notes "token id ...; account id ..."   # non-secret only
   ```
   Facts only: write `unknown` when nobody knows, and add ` (unverified)` to a guess.

Then `evault sync "<type>: <what changed>"` to push the backup.

Project names are lowercase with dashes. Credentials that belong to an account
used by several projects (Apple team keys, Play service account, Cloudflare
account token) go in `shared/<service>`; the project README links to them.

## Restore a missing local copy

```sh
evault ls <project>                                  # what exists (no unlock)
evault show <project>                                # context: used-in says where each copy goes
evault env <project> --out .env.local [--only A,B]   # mode 600; refuses to overwrite without --force
evault get <project> <file-name> --to android/app/   # a file, mode 600
evault get <project> <ENV_NAME>                      # one value to the clipboard for the user (clears in 45s)
```

Before overwriting an existing local file, run `evault compare` and back up
anything that exists only locally.

## Never leak a value

- Never pass `--stdout` to `get` or `env` when the output reaches your
  transcript. Restore to files or the clipboard instead.
- Never `cat`, `echo`, `grep`, `sed` or `jq` a secret file. To see which names
  a file holds: `evault names <file>`. To compare: `evault compare`.
- Never put a value in a command line, commit message, README field or chat.
- If a value was exposed (pasted in chat, screenshot, log, commit, or printed
  by a tool), set `status exposed`, say how in `notes`, and tell the user.

## Audit

```sh
evault audit                 # act now (exposed, expired), soon (rotation, expiring, over a year old), missing facts, backup state
evault audit <project>       # every finding for one project
evault check                 # documentation completeness only
```

Audit reads metadata only: no Touch ID. Report its findings to the user; do not
rotate anything without being asked.
