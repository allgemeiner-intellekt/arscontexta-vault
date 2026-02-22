#!/bin/bash
# Session orientation hook — fires on SessionStart
# Provides context to the agent about vault state

VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
MARKER="$VAULT_ROOT/.arscontexta"

# Only run in Ars Contexta vaults
[ -f "$MARKER" ] || exit 0

# Check if session capture is enabled
SESSION_CAPTURE=$(grep '^session_capture:' "$MARKER" 2>/dev/null | awk '{print $2}')
[ "$SESSION_CAPTURE" = "false" ] && SESSION_NO_CAPTURE=1

# Create session record
SESSION_DIR="$VAULT_ROOT/ops/sessions"
mkdir -p "$SESSION_DIR"
SESSION_ID="${CLAUDE_CONVERSATION_ID:-$(date +%Y%m%d-%H%M%S)}"

if [ -z "$SESSION_NO_CAPTURE" ]; then
  cat > "$SESSION_DIR/current.json" << SEOF
{
  "session_id": "$SESSION_ID",
  "start_time": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "notes_created": [],
  "notes_modified": [],
  "discoveries": [],
  "last_activity": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
SEOF
fi

# Count vault stats for orientation
NOTE_COUNT=$(find "$VAULT_ROOT/notes" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
INBOX_COUNT=$(find "$VAULT_ROOT/inbox" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
OBS_COUNT=$(find "$VAULT_ROOT/ops/observations" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
TENSION_COUNT=$(find "$VAULT_ROOT/ops/tensions" -name "*.md" -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')

# Output orientation context
echo "--- Vault Orientation ---"
echo "Notes: $NOTE_COUNT | Inbox: $INBOX_COUNT | Observations: $OBS_COUNT | Tensions: $TENSION_COUNT"

# Surface condition-based triggers
if [ "$INBOX_COUNT" -ge 10 ] 2>/dev/null; then
  echo "CONDITION: Inbox overflow ($INBOX_COUNT items) — consider /distill or /pipeline"
fi
if [ "$OBS_COUNT" -ge 10 ] 2>/dev/null; then
  echo "CONDITION: Pending observations ($OBS_COUNT) — consider /rethink"
fi
if [ "$TENSION_COUNT" -ge 5 ] 2>/dev/null; then
  echo "CONDITION: Pending tensions ($TENSION_COUNT) — consider /rethink"
fi

# Check reminders
if [ -f "$VAULT_ROOT/ops/reminders.md" ]; then
  TODAY=$(date +%Y-%m-%d)
  OVERDUE=$(grep -c "\- \[ \]" "$VAULT_ROOT/ops/reminders.md" 2>/dev/null || echo 0)
  if [ "$OVERDUE" -gt 0 ]; then
    echo "Reminders: $OVERDUE pending items — check ops/reminders.md"
  fi
fi

echo "--- End Orientation ---"
