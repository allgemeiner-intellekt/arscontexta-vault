---
description: Common issues and resolution patterns
type: manual
generated_from: "arscontexta-0.8.0"
---
# Troubleshooting

## Common Issues

### Orphan Notes
**Symptom:** Notes with no incoming links — they exist but no path leads to them.
**Fix:** Run `/connect` on orphan notes. Use `bash ops/queries/orphan-notes.sh` to find them.
**Prevention:** The connect phase of the pipeline links new notes during creation.

### Dangling Links
**Symptom:** Wiki links pointing to non-existent notes (broken after renames).
**Fix:** Check for broken links after any rename. Use the rename script: `./ops/scripts/rename-note.sh "old title" "new title"`
**Prevention:** Never rename notes manually — always use the rename script.

### Stale Content
**Symptom:** Notes not updated in 30+ days with sparse connections.
**Fix:** Run `/revisit` on stale notes to enrich them with new context.
**Prevention:** Condition-based maintenance flags stale content via `/next`.

### Methodology Drift
**Symptom:** System behavior diverging from what's documented in methodology.
**Fix:** Run `/rethink drift` to detect and address drift.
**Prevention:** Use `/remember` to capture friction signals as they occur.

### Inbox Overflow
**Symptom:** Too many unprocessed items accumulating in `inbox/`.
**Fix:** Run `/pipeline` or `/distill` to process items. Use `/ralph` for orchestrated batch processing.
**Prevention:** Process regularly rather than in large batches.

### Pipeline Stalls
**Symptom:** Tasks stuck in the queue without progressing.
**Fix:** Check with `/next` to see what needs attention. Review `ops/queue/queue.json` for stuck items.

## Common Mistakes

| Mistake | Correction |
|---------|------------|
| Writing directly to notes/ | Always route through inbox/ and the pipeline |
| Manual file renames | Use the rename script to preserve links |
| Ignoring maintenance triggers | Run `/next` regularly to surface conditions |
| Over-capturing without processing | Distill inbox items before adding more |
| Creating maps too early | Maps emerge from content, not from planning |
| Dense schema nobody queries | Remove fields that don't serve retrieval |

See [[meta-skills]] for /rethink and /remember. See [[configuration]] for threshold adjustments.
