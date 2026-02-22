#!/bin/bash
# Extract all outgoing wiki links from a specific note
# Usage: ./ops/scripts/graph/extract-links.sh "note title"
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TITLE="$1"
[ -z "$TITLE" ] && echo "Usage: $0 \"note title\"" && exit 1

FILE=$(find "$VAULT_ROOT" -name "$TITLE.md" -not -path "*/.git/*" 2>/dev/null | head -1)
if [ -z "$FILE" ]; then
  echo "File not found: $TITLE.md"
  exit 1
fi

echo "=== Outgoing links from: $TITLE ==="
grep -o '\[\[[^]]*\]\]' "$FILE" 2>/dev/null | tr -d '[]' | sort -u | while read -r link; do
  target=$(find "$VAULT_ROOT" -name "$link.md" -not -path "*/.git/*" 2>/dev/null | head -1)
  if [ -n "$target" ]; then
    desc=$(grep '^description:' "$target" 2>/dev/null | head -1 | sed 's/description: *//')
    echo "  [[$link]] — $desc"
  else
    echo "  [[$link]] — DANGLING (file not found)"
  fi
done
