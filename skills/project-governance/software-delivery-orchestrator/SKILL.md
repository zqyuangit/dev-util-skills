---
name: software-delivery-orchestrator
description: Use when a software development request needs coordinated skill selection across discovery, design, implementation, debugging, testing, verification, review, deployment, or handoff; especially when multiple local skills could overlap and Codex must choose a conflict-free path before acting.
---

# Software Delivery Orchestrator

## Overview

Use this skill as the routing layer for software delivery work. It selects the lead skill, required sub-skills, and completion gates without duplicating the detailed instructions from those skills.

Do not use this skill as a substitute for the specialized skills. Use it to decide the order and boundaries between them.

## Routing Rules

Choose the earliest unresolved stage, then invoke the matching skill.

| Situation | Lead skill |
| --- | --- |
| Goal, audience, or success criteria are unclear | **REQUIRED SUB-SKILL: Use superpowers:brainstorming**; use `define-goal` when a measurable objective is needed |
| Work starts from PRDs, PDFs, spreadsheets, prototypes, schemas, or API samples | **REQUIRED SUB-SKILL: Use design-from-materials** |
| The project is about to move from concept/prototype into implementation and structure may drift | **REQUIRED SUB-SKILL: Use architecture-freeze-check** |
| Backend/domain behavior includes entities, states, storage, queues, caches, external systems, or consistency risks | **REQUIRED SUB-SKILL: Use domain-solution-designer** |
| Endpoint behavior, request/response schemas, auth, validation, pagination, or error semantics need design | **REQUIRED SUB-SKILL: Use api-contract-designer** |
| The design is accepted and a multi-step implementation plan is needed | **REQUIRED SUB-SKILL: Use superpowers:writing-plans** |
| Implementing a feature, behavior change, refactor, or bug fix | **REQUIRED SUB-SKILL: Use superpowers:test-driven-development** |
| A bug, failing test, CI failure, build failure, or unexpected behavior appears | **REQUIRED SUB-SKILL: Use superpowers:systematic-debugging** |
| Work is about to be described as complete, fixed, passing, ready, or mergeable | **REQUIRED SUB-SKILL: Use superpowers:verification-before-completion** |
| Frontend changes touch login, forms, dialogs, routing, stateful selection, export, or other critical user flows | **REQUIRED SUB-SKILL: Use frontend-critical-flow-acceptance** |

## Execution Coordination

- The user has explicitly authorized Codex to split suitable tasks and use subagents or parallel agents without asking again.
- Do not ask for confirmation merely because subagents would be useful. Decide from task shape: independence, write-set separation, context size, review value, and elapsed-time savings.
- **REQUIRED SUB-SKILL: Use superpowers:dispatching-parallel-agents** when there are two or more independent investigations, verification lanes, or implementation slices that can run concurrently without shared state or file conflicts.
- Use `superpowers:subagent-driven-development` for a written plan with independent tasks inside the current session.
- **REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development** when executing a written implementation plan whose tasks are mostly independent and can benefit from fresh implementer/reviewer contexts.
- Use `multi-session-project-coordinator` only for long-lived Codex threads, worktrees, or multi-session supervision.
- Use `autonomous-development-governor` when deciding whether to continue locally, classify a blocker, require more evidence, or declare completion.
- Use `superpowers:using-git-worktrees` before isolated feature work when a repository worktree is needed.

### Delegation Boundaries

Delegate automatically when doing so improves correctness or speed and the task can be scoped tightly. Keep work inline when the change is tiny, highly coupled, requires one continuous local edit, or a subagent would create more coordination than value.

For coding delegation:

- give each worker a disjoint file or module ownership boundary
- tell workers they are not alone in the codebase and must not revert others' changes
- require concrete output: changed paths, validation run, blockers, and residual risks
- review worker output before integration and run the final verification gate yourself

## Conflict Rules

- Superpowers skills own process discipline: brainstorming, planning, TDD, debugging, verification, review, and finishing. Do not let them replace domain or stack-specific skills.
- Domain and contract skills own pre-implementation design. Do not jump from `design-from-materials` directly into code when entity, state, storage, or endpoint contracts are still ambiguous.
- Stack skills trigger only on explicit stack context, such as `aspnet-core`, `chatgpt-apps`, `winui-app`, or `cli-creator`.
- UI design and validation are separate: use `ui-ux-pro-max` for UI/UX design or review, `frontend-ui-polish-specialist` for existing UI polish, Figma skills for Figma work, and `frontend-critical-flow-acceptance` for final browser-visible flow validation.
- Figma writes or programmatic file-context reads require `figma-use` before any `use_figma` tool call.
- Deployment skills are platform-specific. Use only the requested target: `vercel-deploy`, `netlify-deploy`, `cloudflare-deploy`, or `render-deploy`. If the platform is unclear, ask or plan only; do not deploy.
- Security skills require explicit security intent. Use `security-threat-model`, `security-best-practices`, or `security-ownership-map` only for security-focused requests, not ordinary review.

## Canonical Skills

Prefer these canonical names when duplicates or aliases exist:

- OpenAI product/API/Codex documentation: `openai-docs`.
- PDF tasks where visual layout, rendering, extraction, or generation matters: `pdf`.
- Context7 CLI tasks: `context7-cli`.

## Completion Gates

Before final delivery:

- Run the strongest project-appropriate verification available.
- For user-facing capabilities, verify the full usable chain: user path, permission gate, state closure, and report reality. Do not stop at "code exists" or "API returns locally".
- For commits, follow the active `AGENTS.md` Harness gate first: discover Harness entry points, run the full Harness when present, then run normal relevant tests if no Harness exists.
- For frontend critical flows, require browser evidence or explicitly state that browser validation is still missing.
- Report evidence honestly. Do not claim completion from plans, partial checks, stale output, or another worker's summary alone.

## Common Mistakes

- Loading every plausible skill at once. Route to the earliest unresolved stage and add only required sub-skills.
- Treating UI polish as acceptance testing. Polish improves presentation; acceptance proves user flows work.
- Treating passing unit tests as proof of frontend usability. Critical paths still need browser validation.
- Letting deployment happen as a side effect of "finish the app." Deployment requires a named platform and appropriate approval.
- Calling work done before fresh verification output has been read.
- Writing only the business API while missing security allowlists, frontend entry points, async failure states, or stale reports.
