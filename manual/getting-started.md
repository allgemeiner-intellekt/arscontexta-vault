---
description: First session guide — creating your first note and building connections
type: manual
generated_from: "arscontexta-0.8.0"
---
# Getting Started

## What to Expect

Your knowledge system is a folder of markdown files connected by wiki links, forming a traversable knowledge graph. The agent operates this system — building, maintaining, and navigating it across sessions.

Every session follows a rhythm: **Orient** (remember who you are and what you're working on), **Work** (do the actual thinking), **Persist** (save state before ending).

## Creating Your First Note

Notes live in `notes/`. They are atomic — one idea per file. Titles are propositions that read naturally when linked.

The pipeline enforces quality: raw material goes to `inbox/` first, then gets distilled into atomic notes via `/distill`. This prevents accumulation without processing.

**Example:** You drop an article about AI and labor into `inbox/`. Running `/distill` extracts its key ideas as individual notes:
- `general intellect is knowledge embedded in the means of production.md`
- `automation does not eliminate labor but transforms its character.md`

Each note gets a description, topics, and links to related notes.

## How Connections Work

Wiki links (`[[note title]]`) create edges in your knowledge graph. When you write `[[general intellect is knowledge embedded in the means of production]]` inside another note, you create a traversable connection.

Maps (MOCs) organize notes by theme: `[[philosophy]]`, `[[political-economy]]`, `[[history]]`, `[[ai-and-technology]]`. Every note should link to at least one map.

## The Session Rhythm

1. **Orient** — The agent reads `self/identity.md`, `self/goals.md`, and checks for maintenance triggers
2. **Work** — You and the agent do the actual thinking, reading, writing
3. **Persist** — Update goals, capture new insights, save session state

## Running the Tutorial

For an interactive walkthrough that creates real content: `/arscontexta:tutorial`

## Next Steps

- Read [[workflows]] to understand the full processing pipeline
- Read [[skills]] to see every available command
- Try dropping something into `inbox/` and running `/distill`
