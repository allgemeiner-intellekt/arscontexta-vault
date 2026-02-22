#!/bin/bash
# Auto-commit hook — fires on PostToolUse (Write), async
# Commits changes to git automatically

VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
MARKER="$VAULT_ROOT/.arscontexta"

# Only run in Ars Contexta vaults
[ -f "$MARKER" ] || exit 0

# Check if git auto-commit is enabled
GIT_ENABLED=$(grep '^git:' "$MARKER" 2>/dev/null | awk '{print $2}')
[ "$GIT_ENABLED" = "false" ] && exit 0

# Only commit if there are changes
cd "$VAULT_ROOT" || exit 0
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  exit 0
fi

# Stage and commit
git add -A
git commit -m "auto: vault update $(date +%Y-%m-%d\ %H:%M)" --quiet 2>/dev/null
