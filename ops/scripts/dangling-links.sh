#!/bin/bash
# Find wiki links that point to non-existent files
# Usage: ./ops/scripts/dangling-links.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
echo "=== Dangling Links ==="
grep -roh '\[\[[^]]*\]\]' "$VAULT_ROOT" --include="*.md" 2>/dev/null | \
  tr -d '[]' | sort -u | while read -r link; do
    [ -z "$link" ] && continue
    found=$(find "$VAULT_ROOT" -name "$link.md" -not -path "*/.git/*" 2>/dev/null | head -1)
    if [ -z "$found" ]; then
      echo "  DANGLING: [[$link]]"
      grep -rl "\[\[$link\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null | sed 's/^/    referenced in: /'
    fi
  done
