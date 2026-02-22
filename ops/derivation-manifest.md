---
engine_version: "0.2.0"
research_snapshot: "2026-02-10"
generated_at: "2026-02-22T16:00:00Z"
platform: claude-code
kernel_version: "1.0"

dimensions:
  granularity: atomic
  organization: flat
  linking: explicit+implicit
  processing: heavy
  navigation: 3-tier
  maintenance: condition-based
  schema: moderate
  automation: full

active_blocks:
  - wiki-links
  - processing-pipeline
  - schema
  - maintenance
  - self-evolution
  - methodology-knowledge
  - session-rhythm
  - templates
  - ethical-guardrails
  - helper-functions
  - graph-analysis
  - atomic-notes
  - mocs
  - semantic-search
  - self-space

coherence_result: passed

vocabulary:
  # Level 1: Folder names
  notes: "notes"
  inbox: "inbox"
  archive: "archive"
  ops: "ops"

  # Level 2: Note types
  note: "note"
  note_plural: "notes"

  # Level 3: Schema field names
  description: "description"
  topics: "topics"
  relevant_notes: "relevant notes"

  # Level 4: Navigation terms
  topic_map: "map"
  hub: "index"

  # Level 5: Process verbs
  reduce: "distill"
  reflect: "connect"
  reweave: "revisit"
  verify: "verify"
  validate: "validate"
  rethink: "rethink"

  # Level 6: Command names (as users invoke them)
  cmd_reduce: "/distill"
  cmd_reflect: "/connect"
  cmd_reweave: "/revisit"
  cmd_verify: "/verify"
  cmd_rethink: "/rethink"

  # Level 7: Extraction categories
  extraction_categories:
    - name: "arguments"
      what_to_find: "Logical structures, positions taken by authors, chains of reasoning"
      output_type: "note"
    - name: "concepts"
      what_to_find: "Key ideas, definitions, theoretical constructs, analytical tools"
      output_type: "note"
    - name: "connections"
      what_to_find: "How one thinker relates to another, cross-disciplinary bridges"
      output_type: "note"
    - name: "historical observations"
      what_to_find: "Specific events, patterns, turning points, concrete examples"
      output_type: "note"
    - name: "critiques"
      what_to_find: "Where arguments fail, contradictions, limitations, counter-positions"
      output_type: "note"
    - name: "questions"
      what_to_find: "Unresolved tensions, open problems, things to think about further"
      output_type: "note"

platform_hints:
  context: fork
  allowed_tools:
    - Read
    - Write
    - Edit
    - Glob
    - Grep
    - Bash
    - Task
    - WebSearch
    - WebFetch
  semantic_search_tool: null
  semantic_search_autoapprove:
    - mcp__qmd__search
    - mcp__qmd__vector_search
    - mcp__qmd__deep_search
    - mcp__qmd__get
    - mcp__qmd__multi_get
    - mcp__qmd__status

personality:
  warmth: neutral-helpful
  opinionatedness: neutral
  formality: professional
  emotional_awareness: task-focused
---
