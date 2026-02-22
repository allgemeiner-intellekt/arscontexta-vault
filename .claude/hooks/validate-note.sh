#!/bin/bash
# Validate note hook — fires on PostToolUse (Write)
# Checks that notes written to notes/ have required schema fields

VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
MARKER="$VAULT_ROOT/.arscontexta"

# Only run in Ars Contexta vaults
[ -f "$MARKER" ] || exit 0

# Get the file that was written from the tool input
FILE_PATH="$TOOL_INPUT_FILE_PATH"
[ -z "$FILE_PATH" ] && exit 0

# Only validate files in notes/
case "$FILE_PATH" in
  */notes/*.md) ;;
  *) exit 0 ;;
esac

# Check for required fields
WARNINGS=""

if ! grep -q '^description:' "$FILE_PATH" 2>/dev/null; then
  WARNINGS="${WARNINGS}WARN: Missing 'description' field in $FILE_PATH\n"
fi

if ! grep -q '^topics:' "$FILE_PATH" 2>/dev/null; then
  WARNINGS="${WARNINGS}WARN: Missing 'topics' field in $FILE_PATH\n"
fi

# Check description is not empty
DESC=$(grep '^description:' "$FILE_PATH" 2>/dev/null | sed 's/^description: *//')
if [ -z "$DESC" ] || [ "$DESC" = '""' ] || [ "$DESC" = "''" ]; then
  WARNINGS="${WARNINGS}WARN: Empty description in $FILE_PATH\n"
fi

if [ -n "$WARNINGS" ]; then
  echo -e "$WARNINGS"
fi

# Update session tracking
SESSION_FILE="$VAULT_ROOT/ops/sessions/current.json"
if [ -f "$SESSION_FILE" ]; then
  BASENAME=$(basename "$FILE_PATH")
  # Update last_activity timestamp
  if command -v python3 &>/dev/null; then
    python3 -c "
import json, sys
with open('$SESSION_FILE', 'r') as f:
    data = json.load(f)
note = '$BASENAME'
if note not in data.get('notes_created', []):
    data.setdefault('notes_created', []).append(note)
data['last_activity'] = '$(date -u +%Y-%m-%dT%H:%M:%SZ)'
with open('$SESSION_FILE', 'w') as f:
    json.dump(data, f, indent=2)
" 2>/dev/null
  fi
fi
