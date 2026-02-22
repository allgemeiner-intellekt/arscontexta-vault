#!/bin/bash
# Find everything that leads TO a note within N hops
# Usage: ./ops/scripts/graph/recursive-backlinks.sh "note title" [depth]
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TITLE="$1"
DEPTH="${2:-2}"
[ -z "$TITLE" ] && echo "Usage: $0 \"note title\" [depth]" && exit 1

python3 << PYEOF
import os, re

vault = "$VAULT_ROOT"
notes_dir = os.path.join(vault, 'notes')
target = "$TITLE"
max_depth = int("$DEPTH")

# Build reverse adjacency
reverse_adj = {}
for f in os.listdir(notes_dir):
    if not f.endswith('.md'):
        continue
    name = f[:-3]
    filepath = os.path.join(notes_dir, f)
    with open(filepath, 'r') as fh:
        content = fh.read()
    for link in re.findall(r'\[\[([^\]]+)\]\]', content):
        reverse_adj.setdefault(link, set()).add(name)

visited = set()
current_level = {target}
print(f"=== {max_depth}-hop backward to: {target} ===")

for depth in range(1, max_depth + 1):
    next_level = set()
    for note in current_level:
        visited.add(note)
        for source in reverse_adj.get(note, set()):
            if source not in visited:
                next_level.add(source)
    if next_level:
        print(f"\nDepth {depth}:")
        for n in sorted(next_level):
            print(f"  [[{n}]]")
    current_level = next_level
PYEOF
