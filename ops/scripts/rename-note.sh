#!/bin/bash
# Safe rename — updates all wiki links across the vault
# Usage: ./ops/scripts/rename-note.sh "old title" "new title"
set -e

VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OLD_TITLE="$1"
NEW_TITLE="$2"

if [ -z "$OLD_TITLE" ] || [ -z "$NEW_TITLE" ]; then
  echo "Usage: $0 \"old title\" \"new title\""
  exit 1
fi

# Find the file
OLD_FILE=$(find "$VAULT_ROOT" -name "$OLD_TITLE.md" -not -path "*/.git/*" | head -1)
if [ -z "$OLD_FILE" ]; then
  echo "ERROR: File '$OLD_TITLE.md' not found"
  exit 1
fi

OLD_DIR=$(dirname "$OLD_FILE")
NEW_FILE="$OLD_DIR/$NEW_TITLE.md"

# Rename with git mv
git -C "$VAULT_ROOT" mv "$OLD_FILE" "$NEW_FILE"

# Update all wiki links across the vault
find "$VAULT_ROOT" -name "*.md" -not -path "*/.git/*" -exec \
  sed -i '' "s|\[\[$OLD_TITLE\]\]|\[\[$NEW_TITLE\]\]|g" {} \;

# Update the title inside the file
sed -i '' "s|^# $OLD_TITLE|# $NEW_TITLE|" "$NEW_FILE"

# Verify no broken links
REMAINING=$(grep -rl "\[\[$OLD_TITLE\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$REMAINING" -gt 0 ]; then
  echo "WARNING: $REMAINING files still reference [[$OLD_TITLE]]"
  grep -rl "\[\[$OLD_TITLE\]\]" "$VAULT_ROOT" --include="*.md" 2>/dev/null
else
  echo "Renamed '$OLD_TITLE' -> '$NEW_TITLE' and updated all links"
fi
