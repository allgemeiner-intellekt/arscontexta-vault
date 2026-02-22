#!/bin/bash
# Find notes in the same map that don't link to each other
# Usage: ./ops/scripts/graph/topic-siblings.sh "map name"
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
MAP="$1"
[ -z "$MAP" ] && echo "Usage: $0 \"map name\"" && exit 1

echo "=== Unlinked Siblings in [[$MAP]] ==="

# Find all notes that reference this map
SIBLINGS=$(grep -rl "\[\[$MAP\]\]" "$VAULT_ROOT/notes/" --include="*.md" 2>/dev/null | while read -r f; do
  basename "$f" .md
done | sort)

SIBLING_ARRAY=($SIBLINGS)
for ((i=0; i<${#SIBLING_ARRAY[@]}; i++)); do
  for ((j=i+1; j<${#SIBLING_ARRAY[@]}; j++)); do
    A="${SIBLING_ARRAY[$i]}"
    B="${SIBLING_ARRAY[$j]}"
    A_FILE="$VAULT_ROOT/notes/$A.md"
    B_FILE="$VAULT_ROOT/notes/$B.md"

    A_to_B=$(grep -c "\[\[$B\]\]" "$A_FILE" 2>/dev/null)
    B_to_A=$(grep -c "\[\[$A\]\]" "$B_FILE" 2>/dev/null)

    if [ "$A_to_B" -eq 0 ] && [ "$B_to_A" -eq 0 ]; then
      echo "  [[$A]] <-> [[$B]]"
    fi
  done
done
