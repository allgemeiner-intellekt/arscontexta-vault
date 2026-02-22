#!/bin/bash
# Find notes with no incoming links (orphans)
# Usage: bash ops/queries/orphan-notes.sh
VAULT="${1:-.}"
echo "=== Orphan notes (no incoming links) ==="
for f in "$VAULT"/notes/*.md; do
  [ -f "$f" ] || continue
  basename=$(basename "$f" .md)
  type=$(grep '^type:' "$f" 2>/dev/null | head -1 | sed 's/type: *//')
  [[ "$type" == "moc" ]] && continue
  # Count incoming links across all files
  count=$(grep -rl "\[\[$basename\]\]" "$VAULT"/notes/ "$VAULT"/self/ 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -eq 0 ]; then
    desc=$(grep '^description:' "$f" 2>/dev/null | head -1 | sed 's/description: *//')
    echo "  $basename.md — $desc"
  fi
done
