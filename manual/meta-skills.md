---
description: Deep guide to /ask, /architect, /rethink, and /remember
type: manual
generated_from: "arscontexta-0.8.0"
---
# Meta-Skills

Meta-skills are commands that operate on the system itself rather than on your knowledge content.

## /arscontexta:ask — Query the Research Knowledge Base

Ask questions about your system's methodology, and get answers grounded in the 249-note research knowledge base that backs the design.

```
/arscontexta:ask "Why is atomic granularity recommended for cross-disciplinary work?"
/arscontexta:ask "What are the risks of flat organization at scale?"
```

The response includes specific research claims with practical application to your configuration.

## /arscontexta:architect — Research-Backed Configuration Advice

Get specific, justified proposals for system changes. The architect analyzes your vault's health, compares current state to the original derivation, detects drift, and proposes changes.

```
/arscontexta:architect
```

Use when:
- You feel friction with current settings
- The vault has grown significantly since setup
- You want to add new capabilities (personality, new domains)

## /rethink — Review Observations and Tensions

Triages accumulated friction signals from `ops/observations/` and contradictions from `ops/tensions/`.

```
/rethink
/rethink drift    # Detect methodology drift specifically
```

For each item, /rethink proposes one of: PROMOTE (to notes/), IMPLEMENT (update methodology), ARCHIVE, or KEEP PENDING.

Use when:
- 10+ pending observations accumulate
- 5+ pending tensions accumulate
- System behavior feels like it's drifting from methodology

## /remember — Capture Methodology Learnings

Captures friction signals and operational corrections to `ops/observations/` or `ops/methodology/`.

```
/remember "Schema field X is never useful — remove from template"
/remember "Processing depth should be deep for philosophy sources"
```

This is Rule Zero: methodology is a living spec, not a frozen document. When you notice something about how the system should work, `/remember` captures it for future review.

## How Meta-Skills Relate

```
/remember -> captures observation -> accumulates in ops/observations/
                                           |
                         threshold fires (10+ pending)
                                           |
                                      /rethink -> triages observations
                                           |
                            IMPLEMENT -> updates methodology/config
                            PROMOTE  -> creates note in notes/
                                           |
                         /architect -> detects drift, proposes changes
```

See [[configuration]] for config changes. See [[troubleshooting]] for drift-related issues.
