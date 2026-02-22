#!/bin/bash
# Find notes still in seed status (need development)
# Usage: bash ops/queries/seed-notes.sh
VAULT="${1:-.}"
echo "=== Seed notes (need development) ==="
for f in "$VAULT"/notes/*.md; do
  [ -f "$f" ] || continue
  status=$(grep '^status:' "$f" 2>/dev/null | head -1 | sed 's/status: *//')
  if [ "$status" = "seed" ]; then
    desc=$(grep '^description:' "$f" 2>/dev/null | head -1 | sed 's/description: *//')
    domain=$(grep '^domain:' "$f" 2>/dev/null | head -1 | sed 's/domain: *//')
    echo "  $(basename "$f") [$domain] — $desc"
  fi
done
