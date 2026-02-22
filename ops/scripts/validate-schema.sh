#!/bin/bash
# Validate all notes against template schemas
# Usage: ./ops/scripts/validate-schema.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
PASS=0
WARN=0
FAIL=0

echo "=== Schema Validation ==="
for f in "$VAULT_ROOT"/notes/*.md; do
  [ -f "$f" ] || continue
  NAME=$(basename "$f")
  type=$(grep '^type:' "$f" 2>/dev/null | head -1 | sed 's/type: *//')
  [[ "$type" == "moc" ]] && continue

  ISSUES=""
  if ! grep -q '^description:' "$f" 2>/dev/null; then
    ISSUES="${ISSUES} missing-description"
  fi
  DESC=$(grep '^description:' "$f" 2>/dev/null | sed 's/^description: *//')
  if [ -z "$DESC" ] || [ "$DESC" = '""' ]; then
    ISSUES="${ISSUES} empty-description"
  fi
  if ! grep -q '^topics:' "$f" 2>/dev/null; then
    ISSUES="${ISSUES} missing-topics"
  fi

  if [ -z "$ISSUES" ]; then
    PASS=$((PASS + 1))
  else
    FAIL=$((FAIL + 1))
    echo "  FAIL: $NAME —$ISSUES"
  fi
done

echo ""
echo "Results: $PASS passed, $WARN warnings, $FAIL failed"
