---
_schema:
  entity_type: "observation"
  applies_to: "ops/observations/*.md"
  required:
    - description
    - category
  optional:
    - created
    - status
  enums:
    category:
      - friction
      - surprise
      - process-gap
      - methodology
    status:
      - pending
      - promoted
      - implemented
      - archived
  constraints:
    description:
      max_length: 200
      format: "What was observed and why it matters"

# Template fields
description: ""
category: ""
created: ""
status: pending
---

# {what was observed — prose-as-title}

{What happened, what friction or insight was noticed, what it might mean}

---

Topics:
- [[methodology]]
