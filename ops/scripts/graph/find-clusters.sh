#!/bin/bash
# Find connected components in the knowledge graph
# Usage: ./ops/scripts/graph/find-clusters.sh [--components]
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

# Build adjacency list and find connected components using BFS
python3 << 'PYEOF'
import os, re, sys

vault = os.environ.get('VAULT_ROOT', '.')
notes_dir = os.path.join(vault, 'notes')
if not os.path.isdir(notes_dir):
    print("No notes/ directory found")
    sys.exit(0)

# Build graph
nodes = {}
for f in os.listdir(notes_dir):
    if not f.endswith('.md'):
        continue
    name = f[:-3]
    filepath = os.path.join(notes_dir, f)
    with open(filepath, 'r') as fh:
        content = fh.read()
    links = set(re.findall(r'\[\[([^\]]+)\]\]', content))
    nodes[name] = links

# BFS to find components
visited = set()
components = []
for node in nodes:
    if node in visited:
        continue
    component = set()
    queue = [node]
    while queue:
        current = queue.pop(0)
        if current in visited:
            continue
        visited.add(current)
        component.add(current)
        for neighbor in nodes.get(current, set()):
            if neighbor not in visited and neighbor in nodes:
                queue.append(neighbor)
        for other, links in nodes.items():
            if current in links and other not in visited:
                queue.append(other)
    components.append(component)

components.sort(key=len, reverse=True)

if '--components' in sys.argv:
    print(f"Connected components: {len(components)}")
else:
    print(f"=== {len(components)} Connected Component(s) ===")
    for i, comp in enumerate(components):
        print(f"\nCluster {i+1} ({len(comp)} notes):")
        for note in sorted(comp)[:10]:
            print(f"  {note}")
        if len(comp) > 10:
            print(f"  ... and {len(comp) - 10} more")
PYEOF
