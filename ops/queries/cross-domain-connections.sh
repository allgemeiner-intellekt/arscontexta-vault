#!/bin/bash
# Find notes that bridge two or more domains
# Usage: bash ops/queries/cross-domain-connections.sh
VAULT="${1:-.}"
echo "=== Notes spanning multiple domains ==="
for f in "$VAULT"/notes/*.md; do
  [ -f "$f" ] || continue
  basename=$(basename "$f")
  [[ "$basename" == "index.md" ]] && continue
  domain=$(grep '^domain:' "$f" 2>/dev/null | head -1 | sed 's/domain: *//')
  links=$(grep -o '\[\[[^]]*\]\]' "$f" 2>/dev/null | tr -d '[]' | sort -u)
  link_domains=""
  for link in $links; do
    linked_file="$VAULT/notes/$link.md"
    if [ -f "$linked_file" ]; then
      ld=$(grep '^domain:' "$linked_file" 2>/dev/null | head -1 | sed 's/domain: *//')
      if [ -n "$ld" ] && [ "$ld" != "$domain" ]; then
        link_domains="$link_domains $ld"
      fi
    fi
  done
  if [ -n "$link_domains" ]; then
    echo "  $basename ($domain) -> $link_domains"
  fi
done
