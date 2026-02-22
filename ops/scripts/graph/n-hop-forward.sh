#!/bin/bash
# Find everything reachable within N links from a starting note
# Usage: ./ops/scripts/graph/n-hop-forward.sh "note title" [depth]
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TITLE="$1"
DEPTH="${2:-2}"
[ -z "$TITLE" ] && echo "Usage: $0 \"note title\" [depth]" && exit 1

python3 << PYEOF
import os, re

vault = "$VAULT_ROOT"
notes_dir = os.path.join(vault, 'notes')
start = "$TITLE"
max_depth = int("$DEPTH")

def get_links(name):
    filepath = os.path.join(notes_dir, name + '.md')
    if not os.path.isfile(filepath):
        return set()
    with open(filepath, 'r') as f:
        content = f.read()
    return set(re.findall(r'\[\[([^\]]+)\]\]', content))

visited = set()
current_level = {start}
print(f"=== {max_depth}-hop forward from: {start} ===")

for depth in range(1, max_depth + 1):
    next_level = set()
    for note in current_level:
        visited.add(note)
        for link in get_links(note):
            if link not in visited and os.path.isfile(os.path.join(notes_dir, link + '.md')):
                next_level.add(link)
    if next_level:
        print(f"\nDepth {depth}:")
        for n in sorted(next_level):
            print(f"  [[{n}]]")
    current_level = next_level
PYEOF
