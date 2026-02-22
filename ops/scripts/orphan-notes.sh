#!/bin/bash
# Find notes with no incoming links
# Usage: ./ops/scripts/orphan-notes.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
echo "=== Orphan Notes ==="
for f in "$VAULT_ROOT"/notes/*.md; do
  [ -f "$f" ] || continue
  basename=$(basename "$f" .md)
  type=$(grep '^type:' "$f" 2>/dev/null | head -1 | sed 's/type: *//')
  [[ "$type" == "moc" ]] && continue
  count=$(grep -rl "\[\[$basename\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -eq 0 ]; then
    echo "  ORPHAN: $basename.md"
  fi
done
