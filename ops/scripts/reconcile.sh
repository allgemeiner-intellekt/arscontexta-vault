#!/bin/bash
# Workboard reconciliation — check condition-based maintenance triggers
# Idempotent: safe to run any number of times. Read-only.
# Usage: ./ops/scripts/reconcile.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

echo "=== Condition-Based Maintenance Check ==="

# Orphan notes
ORPHAN_COUNT=0
for f in "$VAULT_ROOT"/notes/*.md; do
  [ -f "$f" ] || continue
  basename=$(basename "$f" .md)
  type=$(grep '^type:' "$f" 2>/dev/null | head -1 | sed 's/type: *//')
  [[ "$type" == "moc" ]] && continue
  count=$(grep -rl "\[\[$basename\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null | wc -l | tr -d ' ')
  [ "$count" -eq 0 ] && ORPHAN_COUNT=$((ORPHAN_COUNT + 1))
done
if [ "$ORPHAN_COUNT" -ge 5 ]; then
  echo "  FIRED: Orphan notes ($ORPHAN_COUNT) — run /connect on orphans"
else
  echo "  OK: Orphan notes ($ORPHAN_COUNT / threshold: 5)"
fi

# Inbox overflow
INBOX_COUNT=$(find "$VAULT_ROOT/inbox" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
if [ "$INBOX_COUNT" -ge 10 ]; then
  echo "  FIRED: Inbox overflow ($INBOX_COUNT items) — run /pipeline or /distill"
else
  echo "  OK: Inbox ($INBOX_COUNT / threshold: 10)"
fi

# Pending observations
OBS_COUNT=$(find "$VAULT_ROOT/ops/observations" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
if [ "$OBS_COUNT" -ge 10 ]; then
  echo "  FIRED: Pending observations ($OBS_COUNT) — run /rethink"
else
  echo "  OK: Observations ($OBS_COUNT / threshold: 10)"
fi

# Pending tensions
TENSION_COUNT=$(find "$VAULT_ROOT/ops/tensions" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
if [ "$TENSION_COUNT" -ge 5 ]; then
  echo "  FIRED: Pending tensions ($TENSION_COUNT) — run /rethink"
else
  echo "  OK: Tensions ($TENSION_COUNT / threshold: 5)"
fi

# Unprocessed sessions
SESSION_COUNT=$(find "$VAULT_ROOT/ops/sessions" -name "*.json" -not -name "current.json" 2>/dev/null | wc -l | tr -d ' ')
if [ "$SESSION_COUNT" -ge 3 ]; then
  echo "  FIRED: Unprocessed sessions ($SESSION_COUNT) — mine for insights"
else
  echo "  OK: Sessions ($SESSION_COUNT / threshold: 3)"
fi

echo "=== End Check ==="
