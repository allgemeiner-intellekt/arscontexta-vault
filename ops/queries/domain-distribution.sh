#!/bin/bash
# Show distribution of notes across domains
# Usage: bash ops/queries/domain-distribution.sh
VAULT="${1:-.}"
echo "=== Domain distribution ==="
for domain in philosophy political-economy history ai methodology; do
  count=$(grep -rl "^domain: $domain" "$VAULT"/notes/ 2>/dev/null | wc -l | tr -d ' ')
  echo "  $domain: $count notes"
done
echo ""
echo "=== Status distribution ==="
for status in seed developing mature; do
  count=$(grep -rl "^status: $status" "$VAULT"/notes/ 2>/dev/null | wc -l | tr -d ' ')
  echo "  $status: $count notes"
done
