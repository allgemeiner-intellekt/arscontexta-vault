---
_schema:
  entity_type: "note"
  applies_to: "notes/*.md"
  required:
    - description
    - topics
  optional:
    - source
    - domain
    - type
    - created
    - status
  enums:
    type:
      - argument
      - concept
      - connection
      - historical-observation
      - critique
      - question
      - synthesis
    domain:
      - philosophy
      - political-economy
      - history
      - ai
      - methodology
    status:
      - seed
      - developing
      - mature
  constraints:
    description:
      max_length: 200
      format: "One sentence adding context beyond the title"
    topics:
      format: "Array of wiki links to maps"

# Template fields
description: ""
topics: []
source: ""
domain: ""
type: ""
created: ""
status: seed
---

# {prose-as-title — a proposition that reads naturally when linked}

{Content — the idea in your own words, transformed from the source, not transcribed}

---

Relevant Notes:
- [[related note]] -- how it connects

Topics:
- [[relevant-map]]
