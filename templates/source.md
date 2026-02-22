---
_schema:
  entity_type: "source"
  applies_to: "inbox/*.md"
  required:
    - description
  optional:
    - author
    - source_type
    - url
    - date_captured
    - processing_status
  enums:
    source_type:
      - book
      - article
      - paper
      - lecture
      - conversation
      - web
    processing_status:
      - captured
      - distilling
      - distilled
      - archived
  constraints:
    description:
      max_length: 200
      format: "What this source is about"

# Template fields
description: ""
author: ""
source_type: ""
url: ""
date_captured: ""
processing_status: captured
---

# {source title}

{Raw content, annotations, highlights — material to be distilled into atomic notes}

---

## Extraction Notes
{What to look for when distilling this source}
