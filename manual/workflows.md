---
description: Processing pipeline, maintenance cycle, and session rhythm
type: manual
generated_from: "arscontexta-0.8.0"
---
# Workflows

## The Processing Pipeline

All content routes through the pipeline: `inbox/` -> `/distill` -> `notes/`. Never write directly to `notes/`.

### Full Pipeline
1. **Seed** (`/seed`) — Create a source entry in inbox/ with metadata
2. **Distill** (`/distill`) — Extract atomic ideas from the source into notes
3. **Connect** (`/connect`) — Find links between new notes and existing ones
4. **Revisit** (`/revisit`) — Update old notes enriched by new context
5. **Verify** (`/verify`) — Check quality, schema, links, discoverability

### Batch Processing
Use `/pipeline` or `/ralph` for orchestrated multi-item processing. These chain phases automatically, maintaining fresh context per phase for quality.

### Processing Depth
Configured in `ops/config.yaml`:
- **deep** — Full pipeline, maximum quality gates. For important sources.
- **standard** — Full pipeline, balanced attention. Regular processing.
- **quick** — Compressed pipeline. High volume catch-up.

## Session Rhythm

Every session follows: **Orient -> Work -> Persist**

### Orient
- Read `self/identity.md` and `self/goals.md`
- Check `ops/reminders.md` for due items
- Run `/next` for intelligent next-action recommendations (evaluates maintenance conditions)

### Work
- Do the actual thinking, reading, writing
- Surface connections as you go
- Write new insights immediately — they won't exist next session

### Persist
- Write new insights as atomic notes
- Update relevant maps
- Update `self/goals.md` with current state
- Session capture hook saves transcript to `ops/sessions/`

## Maintenance Cycle

Maintenance is condition-based — triggered by vault state, not schedules:

| Condition | Threshold | Action |
|-----------|-----------|--------|
| Orphan notes (no incoming links) | 5+ | Run `/connect` on orphans |
| Stale notes (30+ days, sparse links) | 10+ | Run `/revisit` |
| Inbox overflow | 10+ items | Run `/pipeline` or `/distill` |
| Pending observations | 10+ | Run `/rethink` to triage |
| Pending tensions | 5+ | Run `/rethink` to resolve |

The `/next` command evaluates these conditions automatically and surfaces fired triggers as recommendations.

See [[skills]] for command details. See [[configuration]] for adjusting pipeline settings.
