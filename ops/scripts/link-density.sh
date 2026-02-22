#!/bin/bash
# Measure average links per note
# Usage: ./ops/scripts/link-density.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TOTAL_LINKS=0
TOTAL_NOTES=0
for f in "$VAULT_ROOT"/notes/*.md; do
  [ -f "$f" ] || continue
  type=$(grep '^type:' "$f" 2>/dev/null | head -1 | sed 's/type: *//')
  [[ "$type" == "moc" ]] && continue
  LINKS=$(grep -o '\[\[[^]]*\]\]' "$f" 2>/dev/null | wc -l | tr -d ' ')
  TOTAL_LINKS=$((TOTAL_LINKS + LINKS))
  TOTAL_NOTES=$((TOTAL_NOTES + 1))
done
if [ "$TOTAL_NOTES" -gt 0 ]; then
  AVG=$(echo "scale=1; $TOTAL_LINKS / $TOTAL_NOTES" | bc 2>/dev/null || echo "N/A")
  echo "Link density: $AVG links/note ($TOTAL_LINKS links across $TOTAL_NOTES notes)"
  echo "Target: 3+ links per note"
else
  echo "No notes found yet"
fi
