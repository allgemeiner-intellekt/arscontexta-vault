#!/bin/bash
# Session capture hook — fires on Stop
# Archives current session data

VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
MARKER="$VAULT_ROOT/.arscontexta"

# Only run in Ars Contexta vaults
[ -f "$MARKER" ] || exit 0

SESSION_CAPTURE=$(grep '^session_capture:' "$MARKER" 2>/dev/null | awk '{print $2}')
[ "$SESSION_CAPTURE" = "false" ] && exit 0

SESSION_DIR="$VAULT_ROOT/ops/sessions"
CURRENT="$SESSION_DIR/current.json"

# Archive current session if it exists
if [ -f "$CURRENT" ]; then
  TIMESTAMP=$(date +%Y%m%d-%H%M%S)
  cp "$CURRENT" "$SESSION_DIR/$TIMESTAMP.json"
fi
