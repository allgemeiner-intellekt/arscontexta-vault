#!/bin/bash
# Find open triangles: A->B and A->C but B and C are not linked
# These are synthesis opportunities
# Usage: ./ops/scripts/graph/find-triangles.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
echo "=== Open Triangles (Synthesis Opportunities) ==="

for f in "$VAULT_ROOT"/notes/*.md; do
  [ -f "$f" ] || continue
  A=$(basename "$f" .md)
  type=$(grep '^type:' "$f" 2>/dev/null | head -1 | sed 's/type: *//')
  [[ "$type" == "moc" ]] && continue

  links=$(grep -o '\[\[[^]]*\]\]' "$f" 2>/dev/null | tr -d '[]' | sort -u)
  link_array=($links)

  for ((i=0; i<${#link_array[@]}; i++)); do
    for ((j=i+1; j<${#link_array[@]}; j++)); do
      B="${link_array[$i]}"
      C="${link_array[$j]}"
      B_FILE="$VAULT_ROOT/notes/$B.md"
      C_FILE="$VAULT_ROOT/notes/$C.md"

      [ -f "$B_FILE" ] || continue
      [ -f "$C_FILE" ] || continue

      # Check if B links to C or C links to B
      B_to_C=$(grep -c "\[\[$C\]\]" "$B_FILE" 2>/dev/null)
      C_to_B=$(grep -c "\[\[$B\]\]" "$C_FILE" 2>/dev/null)

      if [ "$B_to_C" -eq 0 ] && [ "$C_to_B" -eq 0 ]; then
        echo "  $A connects to both:"
        echo "    [[$B]]"
        echo "    [[$C]]"
        echo "    (but they don't link to each other)"
        echo ""
      fi
    done
  done
done
