---
name: evault
description: |
  Store, find and use development secrets with the evault CLI: API keys, tokens,
  passwords, database URLs, .env values, signing keystores, Apple .p8 keys,
  service-account JSON, any credential file. Use whenever a secret is created,
  received, rotated, needed for a build or a .env file, or looked for ("where is
  the X key", "what was the value of", "set up .env.local", "upload keystore",
  "save this token"). Also use when a secret was exposed and needs a rotation note.
---

# evault

Every development secret lives in the evault data repo (`evault path`, normally
`~/evault`), one folder per project, each value encrypted, each documented in
the project's README. The vault is the source of truth; project `.env` files
are copies generated from it.

Format reference (folders, README fields): `docs/format.md` in the evault CLI
repo (`$(dirname $(dirname $(readlink -f $(command -v evault))))/docs/format.md`).

## Never leak a value

- Never pass `--stdout` to `get` or `env` when the output reaches your
  transcript. Use the clipboard (`evault get`), a file (`evault get --to`,
  `evault env --out`), or `evault exec <project> -- <cmd>`.
- Never `cat`, `echo` or `grep` a decrypted file or an `.env` file. To see which
  names a file holds: `sed -E 's/=.*/=<redacted>/' FILE`.
- To compare a project's `.env` with the vault: `evault compare <project> FILE`.
- Never put a value in a command line, commit message, README field or chat.

## Find something

```sh
evault ls                    # projects
evault ls <project>          # items: kind, status, expiry, what
evault show <project>        # full README: context for every item
evault check                 # undocumented items, rotation flags, expiry within 30 days
```

Project names are lowercase with dashes; account-level credentials used by
several projects live in `shared/<service>`. Look there too.

## Save a secret

When you create a credential, generate one (a session secret, a password), or
the user gives you one, store it before doing anything else with it.

```sh
# A value: ask the user to copy it, then (reads the clipboard, never prints, clears it)
evault set <project> <ENV_NAME>
# A value you generated in a script, piped without echoing it:
<command that prints the value> | evault set <project> <ENV_NAME> --stdin
# A file (keystore, .p8, JSON key):
evault add <project> <path> [--name <file-name>]
# A whole .env file (keeps existing values; reports differences):
evault import <project> <env-file>
```

Use the exact env var name the project reads. Replacing a value needs `--force`.

## Document it (required, right after saving)

`set`, `add` and `import` create a README section with TODO fields. Fill every
one, with facts, not guesses (write `unknown` if nobody knows):

```sh
evault meta <project> <name> what "Cloudflare R2 token for the media bucket"
evault meta <project> <name> used-in "apps/web/.env.local; Vercel env (production)"
evault meta <project> <name> created 2026-10-16
evault meta <project> <name> expires never            # or YYYY-MM-DD
evault meta <project> <name> scope "R2 read+write, bucket media only"
evault meta <project> <name> recoverable "no: shown once at creation"
evault meta <project> <name> rotate "Cloudflare > R2 > API tokens > roll; update Vercel env"
evault meta <project> <name> status ok                # ok | rotate | exposed | revoked
evault meta <project> <name> notes "token id abc...; account id ..."   # non-secret only
```

If a value was exposed (pasted in a chat, shown in a screenshot, logged, or
committed), set `status exposed` and say how in `notes`, then tell the user it
needs rotating.

Also keep the project's opening paragraph in `<project>/README.md` current:
what the project is, where it runs, which accounts own its keys.

## Use a secret

```sh
evault env <project> --out .env.local [--only A,B]   # mode 600; refuses to overwrite without --force
evault get <project> <file-name> --to android/app/   # decrypt a file, mode 600
evault exec <project> [--only A,B] -- <command>      # run with values in the environment
evault get <project> <ENV_NAME>                      # to the clipboard for the user, clears in 45s
```

Before overwriting an existing `.env`, run `evault compare` and import anything
that exists only in the file.

## Finish

```sh
evault check <project>     # nothing left as TODO
evault sync "<type>: <what changed>"   # commit and push the encrypted repo
```

Reading needs Touch ID through 1Password. If `op` fails, ask the user to unlock
1Password; do not look for the key anywhere else. Saving never needs it.
