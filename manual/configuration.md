---
description: How to adjust your system via config.yaml and /architect
type: manual
generated_from: "arscontexta-0.8.0"
---
# Configuration

## config.yaml

Your system's live configuration lives at `ops/config.yaml`. Edit it directly to change settings. Changes take effect next session.

### Key Dimensions

| Dimension | Current | Meaning |
|-----------|---------|---------|
| granularity | atomic | One idea per note |
| organization | flat | No folder hierarchy within notes/ |
| linking | explicit+implicit | Wiki links + semantic search discovery |
| processing | heavy | Deep extraction from sources |
| navigation | 3-tier | Index -> domain maps -> notes |
| maintenance | condition-based | Triggered by vault state |
| schema | moderate | Structured but not bureaucratic |
| automation | full | All capabilities from day one |

### Processing Settings

- `processing.depth`: deep / standard / quick
- `processing.chaining`: manual / suggested / automatic
- `processing.extraction.selectivity`: strict / moderate / permissive

### Features

- `features.semantic-search`: Enable/disable semantic search via qmd
- `features.processing-pipeline`: Enable/disable the full pipeline
- `personality.enabled`: Enable/disable agent personality layer

## Using /architect

For guided configuration changes with research-backed rationale:

```
/arscontexta:architect
```

The architect command analyzes your vault state, compares it to the derivation in `ops/derivation.md`, detects drift, and proposes specific changes with justification.

## Presets

Your system was derived from a custom configuration closest to the Research preset, adapted for cross-disciplinary intellectual work. Key adaptations:
- Self-space enabled (not default for research)
- Vocabulary uses "distill/connect/revisit" instead of "reduce/reflect/reweave"
- Domain maps span philosophy, political economy, history, AI

## Adjusting Post-Setup

You can change any dimension at any time. Common adjustments:
- Raise processing depth for important sources: set `processing.depth: deep`
- Speed up batch processing: set `processing.depth: quick`
- Add schema fields: edit templates in `templates/`
- Add new domain maps: create a new map in `notes/` following the map template

See [[meta-skills]] for /architect details. See [[troubleshooting]] for configuration issues.
