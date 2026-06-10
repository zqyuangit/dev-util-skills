---
name: software-demo-ppt-real-prototype
description: Create or revise formal software demo, product introduction, defense, inspection, or acceptance PPT decks using real runnable program screens or verifiable UI screenshots as prototypes. Use when a presentation must show authentic software pages, avoid conceptual mockups, keep slide text/charts editable, and face judges, reviewers, clients, or acceptance panels.
---

# Software Demo PPT With Real Prototypes

## Purpose

Use this skill to create formal software demonstration PPT decks that rely on real program UI evidence. The deck should be judge-, reviewer-, client-, or acceptance-facing, not a private rehearsal guide.

This skill is for PPT/PPTX work. For software copyright manuals or operation reports, use `software-copyright-report` instead.

## Non-Negotiable Rules

- Page prototypes must come from a real runnable program, existing product, source-code-derived UI, or user-provided verified screenshots.
- Do not invent hand-drawn, conceptual, or decorative mockups when the deck claims to show implemented software.
- If the program cannot be run or screenshots cannot be verified, mark the UI as `界面待验证` instead of presenting it as real.
- Do not rasterize entire slides into full-page images. Keep titles, body copy, charts, progress bars, tables, diagrams, labels, and captions editable.
- Only actual UI screenshots, product photos, logos, and bitmap assets should be images.
- Capture screenshots at high resolution. Prefer browser/device scale factor 2 or native app screenshots large enough for projection.
- Remove speaker-only content such as 答辩技巧, 主讲提醒, “这一页要说”, and private notes from visible slides.
- Do not overclaim unimplemented functions. Use `已实现`, `基础能力已具备`, `待完善`, or `后续增强` based on evidence.

## Workflow

1. **Inspect sources**
   - Read the user-provided PPT, requirements, README, source tree, screenshots, and existing report materials.
   - If a local app path is provided, inspect run/build files and identify how to launch or render the real UI.
   - If the user provides both a repo and a packaged program, treat the packaged program as the UI source of truth unless told otherwise.

2. **Acquire real prototypes**
   - Run or serve the real application when feasible.
   - Capture pages from the actual UI with stable demo data.
   - Preserve tab names, layout, colors, spacing, and visible controls from the real program.
   - If the app cannot run, use existing verified screenshots and label uncertainty clearly.

3. **Plan the deck**
   - Read `references/deck-structure.md` for formal deck structure.
   - Keep the deck concise: default 12-15 pages unless the user specifies another count.
   - Put proof objects on most slides: real UI, architecture diagram, completion table, workflow, or engineering evidence.

4. **Build editable slides**
   - Use presentation tooling that creates editable PowerPoint objects.
   - Use screenshots only inside framed UI evidence areas.
   - Build progress bars, tables, flows, captions, section labels, and summary cards as editable shapes/text.
   - Avoid full-slide PNGs except as temporary previews; never deliver them as the production PPT.

5. **Quality gate**
   - Read `references/prototype-quality-gate.md` before final delivery.
   - Verify slide count, embedded media count, empty media count, and editable text presence.
   - Create a contact sheet or preview images for visual QA.
   - Confirm visible screenshots match the real program UI source.

## Audience Rules

For judge/reviewer-facing decks:

- Lead with software value, required function coverage, and verifiable evidence.
- Replace long prose with completion tables, workflows, screenshots, and engineering proof.
- Keep page titles claim-oriented and specific.
- Keep visible wording objective; avoid exaggerated marketing and internal process commentary.
- Put limitations and pending work in a controlled, honest form.

## Deliverables

Default deliverables for a full deck task:

- Editable `.pptx`
- Contact sheet or preview PNG overview
- Optional matching speaker script if requested

Do not modify an existing speaker script unless the user explicitly asks.

## References

- For slide sequence and page archetypes, read `references/deck-structure.md`.
- For real-prototype and editability checks, read `references/prototype-quality-gate.md`.
