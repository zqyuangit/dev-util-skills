---
name: ticket-breakdown
description: Break a task or ticket into small steps. Use when a junior developer needs guidance on how to start.
---

# Ticket Breakdown

## Purpose
Break a task or ticket into small steps.

## Inputs to request
- Ticket description and acceptance criteria.
- Target files or components.
- Known constraints or deadlines.

## Workflow
1. Summarize the ticket goal and acceptance criteria.
2. Split into implementation steps with dependencies.
3. Identify what to test and how to validate.

## Output
- Step-by-step task list with checks.

## Collaboration
- Upstream: use after the goal and acceptance criteria are clear.
- Downstream: hand off to `autonomous-development-governor` when the agent must decide what to do next, or to `multi-session-project-coordinator` only after governor determines the work should be parallelized.
- Handoff output: include steps, dependencies, validation checks, and missing requirements.

## Quality bar
- Keep steps small and testable.
- Highlight any missing requirements.
