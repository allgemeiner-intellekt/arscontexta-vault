#!/bin/bash
# View queue status: pending tasks, phase distribution, stalled items
# Usage: ./ops/scripts/queue-status.sh
VAULT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
QUEUE="$VAULT_ROOT/ops/queue/queue.json"

if [ ! -f "$QUEUE" ]; then
  echo "No queue file found at $QUEUE"
  exit 0
fi

python3 << PYEOF
import json

with open("$QUEUE", 'r') as f:
    data = json.load(f)

queue = data.get('queue', [])
if not queue:
    print("Queue is empty — no pending tasks")
else:
    print(f"=== Queue Status ({len(queue)} items) ===")
    phases = {}
    types = {}
    for item in queue:
        phase = item.get('phase', 'unknown')
        itype = item.get('type', 'pipeline')
        phases[phase] = phases.get(phase, 0) + 1
        types[itype] = types.get(itype, 0) + 1

    print("\nBy phase:")
    for phase, count in sorted(phases.items()):
        print(f"  {phase}: {count}")

    print("\nBy type:")
    for itype, count in sorted(types.items()):
        print(f"  {itype}: {count}")
PYEOF
