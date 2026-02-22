#!/bin/bash
# Find all files that link to a specific note
# Usage: ./ops/scripts/backlinks.sh "note title" [--count]
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TITLE="$1"
[ -z "$TITLE" ] && echo "Usage: $0 \"note title\" [--count]" && exit 1

if [ "$2" = "--count" ]; then
  grep -rl "\[\[$TITLE\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null | wc -l | tr -d ' '
else
  echo "=== Backlinks to [[$TITLE]] ==="
  grep -rl "\[\[$TITLE\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null | while read -r f; do
    echo "  $(basename "$f")"
  done
fi
