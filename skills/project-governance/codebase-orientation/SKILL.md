---
name: codebase-orientation
description: Guide quick orientation of an unfamiliar codebase with module mapping, entry points, and local run steps. Use when a junior developer needs to get situated fast.
---

# Codebase Orientation

## Purpose
Guide quick orientation of an unfamiliar codebase with module mapping, entry points, and local run steps.

## Inputs to request
- Repo URL or local path and target area of interest.
- Runtime versions, package manager, and OS.
- Current task or reason for onboarding.

## Workflow
1. Locate entry points, build scripts, and main runtime paths.
2. Map key folders, ownership, and common naming conventions.
3. Identify how to run, test, and debug locally with minimal setup.
4. Call out one or two safe starter tasks for learning.

## Output
- High-level module map with file paths.
- Local run/test commands with prerequisites.
- Suggested first change with low risk.

## Collaboration
- Upstream: use after `define-goal`, a repo link, or a user request to understand an unfamiliar codebase.
- Downstream: hand off to `architecture-freeze-check` for structural risk, `domain-solution-designer` for backend/domain design, or `autonomous-development-governor` when the next step is deciding whether to implement or verify.
- Handoff output: include entry points, key modules, run/test commands, and any risky unknowns.

## Quality bar
- Reference concrete file paths and commands.
- Keep scope limited to the requested area.
