---
_schema:
  entity_type: "map"
  applies_to: "notes/*-map.md"
  required:
    - description
    - type
  optional:
    - domain
    - created
  enums:
    type:
      - moc
  constraints:
    description:
      max_length: 200
      format: "What this map organizes and why it matters"

# Template fields
description: ""
type: moc
domain: ""
created: ""
---

# {map title}

{Brief description of what this map covers and how to navigate it}

## Core Notes
{Links to the most important notes in this area}

## Developing
{Links to notes that are still growing}

## Questions
{Links to open questions and unresolved tensions}

---

Topics:
- [[index]]
