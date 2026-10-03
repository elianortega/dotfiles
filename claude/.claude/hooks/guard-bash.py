#!/usr/bin/env python3
"""PreToolUse guard for Bash.

Sessions run without permission prompts, so the two rules that must never be
skipped are enforced here instead of relying on instruction text:

  1. Production deploys need the user to have asked for that deploy.
  2. Pushes to protected remotes need the user's yes.

A blocked command is not a dead end. When the user did ask, the command is
re-run with the matching marker (CLAUDE_DEPLOY_OK=1 or CLAUDE_PUSH_OK=1) as an
environment prefix. The marker is the model attesting that the user asked; the
block message says so, which is the point of the speed bump.

Exit 2 blocks the call and returns stderr to the model. Any internal error
exits 0: a broken guard must not stop work.
"""

import json
import os
import re
import subprocess
import sys

DEPLOY_MARKER = "CLAUDE_DEPLOY_OK=1"
PUSH_MARKER = "CLAUDE_PUSH_OK=1"

# A deploy tool only counts at a command position (start, or after ; & | ( or a
# newline), optionally behind env assignments and a runner such as npx or
# `pnpm exec`. That keeps `grep "supabase db push" docs/` from being blocked.
COMMAND_POSITION = (
    r"(?:^|[;&|(\n])\s*(?:\w+=\S+\s+)*"
    r"(?:(?:npx|bunx|pnpm|yarn|fvm)\s+(?:(?:exec|dlx|-y|--yes)\s+)*)?"
)

# Commands that change something users of a live product can see.
DEPLOY_PATTERNS = [
    (r"supabase\s+db\s+push\b", "supabase db push"),
    (r"supabase\s+functions\s+deploy\b", "supabase functions deploy"),
    (r"supabase\s+migration\s+up\b[^;&|\n]*--linked", "supabase migration up --linked"),
    (r"supabase\s+db\s+reset\b[^;&|\n]*--linked", "supabase db reset --linked"),
    (r"shorebird\s+(?:patch|release)\b", "shorebird patch/release"),
    (r"wrangler\s+(?:pages\s+)?deploy\b", "wrangler deploy"),
    (r"firebase\s+deploy\b", "firebase deploy"),
    (r"vercel\b[^;&|\n]*--prod\b", "vercel --prod"),
]

# Rehearsals and local stacks are not deploys.
NOT_A_DEPLOY = re.compile(r"--dry-run\b|--local\b")

# An org or repo segment that is `nu`, starts with `nu-`, or contains `nubank`,
# plus one repository protected by name.
PROTECTED_REMOTE = re.compile(r"nubank|[:/]nu[-/]|mini-meta-repo", re.IGNORECASE)


def block(message):
    sys.stderr.write(message + "\n")
    sys.exit(2)


def remote_urls(cwd):
    try:
        out = subprocess.run(
            ["git", "remote", "-v"],
            cwd=cwd or None,
            capture_output=True,
            text=True,
            timeout=3,
        ).stdout
    except Exception:
        return ""
    return out


# One `git ... push ...` invocation, up to the next shell separator.
PUSH_SEGMENT = re.compile(r"\bgit\b[^|;&\n]*\bpush\b[^|;&\n]*")


def push_directory(command, segment, default):
    """Where the push runs: `git -C <dir>`, else the last `cd <dir>` before it."""
    explicit = re.search(r"\bgit\s+-C\s+(\S+)", segment)
    if explicit:
        return explicit.group(1).strip("'\"")
    before = command[: command.find(segment)]
    moves = re.findall(r"(?:^|[;&|(\n])\s*cd\s+(\S+)", before)
    if moves:
        return moves[-1].strip("'\"")
    return default


def main():
    payload = json.load(sys.stdin)
    if payload.get("tool_name") != "Bash":
        return
    command = (payload.get("tool_input") or {}).get("command") or ""
    if not command:
        return

    if DEPLOY_MARKER not in command and not NOT_A_DEPLOY.search(command):
        for pattern, label in DEPLOY_PATTERNS:
            if re.search(COMMAND_POSITION + pattern, command):
                block(
                    f"Blocked by guard-bash: `{label}` deploys to a live environment.\n"
                    "Deploy only when the user asked for this deploy in this conversation "
                    "('merge' is not 'deploy').\n"
                    f"If they did, re-run the same command prefixed with {DEPLOY_MARKER}.\n"
                    "If they did not, do not deploy: report it as pending."
                )

    if PUSH_MARKER in command:
        return
    # Only the push invocation and the remotes it can reach are inspected, so a
    # command that merely mentions a protected name elsewhere is not blocked.
    for match in PUSH_SEGMENT.finditer(command):
        segment = match.group(0)
        directory = os.path.expanduser(
            push_directory(command, segment, payload.get("cwd"))
        )
        if not os.path.isabs(directory):
            directory = os.path.join(payload.get("cwd") or "", directory)
        if PROTECTED_REMOTE.search(segment + "\n" + remote_urls(directory)):
            block(
                "Blocked by guard-bash: this push targets a protected repository "
                "(Nubank or mini-meta-repo).\n"
                "Ask the user first. After an explicit yes, re-run the same command "
                f"prefixed with {PUSH_MARKER}."
            )

if __name__ == "__main__":
    try:
        main()
    except SystemExit:
        raise
    except Exception:
        sys.exit(0)
