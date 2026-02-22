#!/bin/bash
# Rank notes by link patterns: hubs (many outgoing), authorities (many incoming), synthesizers (both)
# Usage: ./ops/scripts/graph/influence-flow.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

python3 << 'PYEOF'
import os, re, sys

vault = os.environ.get('VAULT_ROOT', '.')
notes_dir = os.path.join(vault, 'notes')
if not os.path.isdir(notes_dir):
    print("No notes/ directory found")
    sys.exit(0)

outgoing = {}
incoming = {}

for f in os.listdir(notes_dir):
    if not f.endswith('.md'):
        continue
    name = f[:-3]
    filepath = os.path.join(notes_dir, f)
    with open(filepath, 'r') as fh:
        content = fh.read()

    # Check if MOC
    if 'type: moc' in content:
        continue

    links = re.findall(r'\[\[([^\]]+)\]\]', content)
    outgoing[name] = len(links)
    for link in links:
        incoming[link] = incoming.get(link, 0) + 1

all_notes = set(outgoing.keys())

print("=== Top Hubs (most outgoing links) ===")
hubs = sorted(all_notes, key=lambda n: outgoing.get(n, 0), reverse=True)[:5]
for n in hubs:
    print(f"  {n}: {outgoing.get(n, 0)} outgoing")

print("\n=== Top Authorities (most incoming links) ===")
auths = sorted(all_notes, key=lambda n: incoming.get(n, 0), reverse=True)[:5]
for n in auths:
    print(f"  {n}: {incoming.get(n, 0)} incoming")

print("\n=== Synthesizers (high incoming AND outgoing) ===")
synth = sorted(all_notes, key=lambda n: min(outgoing.get(n, 0), incoming.get(n, 0)), reverse=True)[:5]
for n in synth:
    print(f"  {n}: {incoming.get(n, 0)} in, {outgoing.get(n, 0)} out")
PYEOF
