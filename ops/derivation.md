---
description: How this knowledge system was derived -- enables architect and reseed commands
created: 2026-02-22
engine_version: "1.0.0"
---

# System Derivation

## Configuration Dimensions
| Dimension | Position | Conversation Signal | Confidence |
|-----------|----------|--------------------|--------------------|
| Granularity | atomic | "reading widely, extracting the ideas that matter, building a connected critical framework" | High |
| Organization | flat | Cross-disciplinary thinking across philosophy, economics, history, AI — hierarchy would impose artificial boundaries | High |
| Linking | explicit+implicit | "if I can recall them, they exist" — externalizing connections is the core value; semantic search for undiscovered connections | High |
| Processing | heavy | Dense philosophical and economic texts (Grundrisse, phenomenology, heterodox economics) require serious extraction | High |
| Navigation | 3-tier | Broad terrain spanning 4+ domains needs layered topic maps | High |
| Maintenance | condition-based | Default — no signal either way | Inferred |
| Schema | moderate | Intellectual practice values ideas over metadata, but enough structure to enable discovery | Medium |
| Automation | full | Claude Code platform + comfort with AI tools ("use AI to convert an article into Markdown") | High |

## Personality Dimensions
| Dimension | Position | Signal |
|-----------|----------|--------|
| Warmth | neutral-helpful | default — no strong signal |
| Opinionatedness | neutral | default — no strong signal |
| Formality | professional | Serious intellectual engagement, philosophical material |
| Emotional Awareness | task-focused | default — intellectual rather than personal domain |

## Vocabulary Mapping
| Universal Term | Domain Term | Category |
|---------------|-------------|----------|
| notes | notes | folder |
| inbox | inbox | folder |
| archive | archive | folder |
| note (type) | note | note type |
| reduce | distill | process phase |
| reflect | connect | process phase |
| reweave | revisit | process phase |
| verify | verify | process phase |
| validate | validate | process phase |
| rethink | rethink | process phase |
| MOC | map | navigation |
| topic map | map | navigation |
| description | description | schema field |
| topics | topics | schema field |
| relevant notes | relevant notes | schema field |
| hub | index | navigation |
| remember | remember | growth |
| learn | learn | growth |
| seed | seed | orchestration |
| pipeline | pipeline | orchestration |
| refactor | refactor | evolution |

## Platform
- Tier: Claude Code
- Automation level: full
- Automation: full (default)

## Active Feature Blocks
- [x] wiki-links -- always included (kernel)
- [x] maintenance -- always included (always)
- [x] self-evolution -- always included (always)
- [x] session-rhythm -- always included (always)
- [x] templates -- always included (always)
- [x] ethical-guardrails -- always included (always)
- [x] helper-functions -- always included (always)
- [x] graph-analysis -- always included (always)
- [x] processing-pipeline -- always included (always)
- [x] schema -- always included (always)
- [x] methodology-knowledge -- always included (always)
- [x] atomic-notes -- granularity = atomic
- [x] mocs -- navigation = 3-tier
- [x] semantic-search -- linking = explicit+implicit
- [x] self-space -- intellectual practice benefits from persistent agent memory
- [ ] personality -- no strong personality signals; neutral-helpful default
- [ ] multi-domain -- single domain with topic maps per area; cross-domain connections are the point

## Coherence Validation Results
- Hard constraints checked: 3. Violations: none
  - atomic + 3-tier + volume (projected moderate-high): PASS — 3-tier navigation handles scale
  - full automation + Claude Code platform: PASS — platform supports full automation
  - heavy processing + full automation + pipeline skills: PASS — pipeline is generated
- Soft constraints checked: 5. Auto-adjusted: none. User-confirmed: none
  - atomic + heavy processing: COHERENT — atomic notes need heavy processing to recreate decomposed context
  - moderate schema + full automation: COHERENT — automation handles schema enforcement
  - explicit+implicit linking + semantic search: COHERENT — semantic search enables implicit linking
  - heavy processing + condition-based maintenance: COHERENT — conditions will fire appropriately
  - flat + 3-tier navigation: COHERENT — MOCs provide navigation without hierarchical folders
- Compensating mechanisms active: semantic search compensates for potential orphan drift in flat atomic system

## Failure Mode Risks
1. Collector's Fallacy (HIGH) — broad reading across philosophy, economics, history, AI creates temptation to capture without processing. Pipeline enforcement and condition-based triggers compensate.
2. Orphan Drift (HIGH) — atomic notes across many domains can lose connections if connect phase is skipped. Semantic search and maintenance conditions compensate.
3. Temporal Staleness (MEDIUM) — fast-moving AI domain mixed with stable philosophy means uneven freshness requirements. Condition-based maintenance flags stale content.
4. Verbatim Risk (MEDIUM) — dense philosophical texts tempt direct quotation over transformation. Processing pipeline enforces distillation.

## Generation Parameters
- Folder names: notes, inbox, archive, self, ops, templates, manual
- Skills to generate: all 16 — vocabulary-transformed (distill, connect, revisit, verify, validate, seed, ralph, pipeline, tasks, stats, graph, next, learn, remember, rethink, refactor)
- Hooks to generate: session-orient.sh, session-capture.sh, validate-note.sh, auto-commit.sh
- Templates to create: note.md, map.md, source.md, observation.md
- Topology: single-agent, skills, fresh-context
