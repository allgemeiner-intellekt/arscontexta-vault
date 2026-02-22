#!/bin/bash
# Find bridge notes — nodes whose removal would disconnect parts of the graph
# Usage: ./ops/scripts/graph/find-bridges.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

python3 << 'PYEOF'
import os, re, sys

vault = os.environ.get('VAULT_ROOT', '.')
notes_dir = os.path.join(vault, 'notes')
if not os.path.isdir(notes_dir):
    print("No notes/ directory found")
    sys.exit(0)

# Build bidirectional graph
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

# Build undirected adjacency
adj = {n: set() for n in nodes}
for n, links in nodes.items():
    for link in links:
        if link in nodes:
            adj[n].add(link)
            adj[link].add(n)

# Find articulation points (bridges)
def count_components(graph, exclude=None):
    visited = set()
    if exclude:
        visited.add(exclude)
    components = 0
    for node in graph:
        if node in visited:
            continue
        components += 1
        queue = [node]
        while queue:
            current = queue.pop(0)
            if current in visited:
                continue
            visited.add(current)
            for neighbor in graph.get(current, set()):
                if neighbor not in visited:
                    queue.append(neighbor)
    return components

base_components = count_components(adj)
bridges = []

for node in adj:
    if len(adj[node]) < 2:
        continue
    new_components = count_components(adj, exclude=node)
    if new_components > base_components:
        bridges.append((node, len(adj[node]), new_components - base_components))

bridges.sort(key=lambda x: x[2], reverse=True)

print("=== Bridge Notes (structurally critical) ===")
if not bridges:
    print("  No bridge notes found — graph is well-connected")
else:
    for name, degree, split in bridges:
        print(f"  {name} (degree: {degree}, would create {split} new component(s))")
PYEOF
