---
name: multi-session-project-coordinator
description: Use when coordinating multiple existing Codex threads or sessions, or when evaluating a completed development plan to decide whether workload, domain boundaries, risk, duration, and the optimal number of workers justify multi-session division of labor; also use when planning, creating, binding, dispatching, supervising, polling, or integrating long-lived Codex worker sessions across project worktrees, pending forks, fallback worktrees, approvals, blockers, and safety boundaries.
---

# Multi-Session Project Coordinator

## Overview

Use this skill to act as the coordinator for several Codex sessions that share one project but own different scopes. The coordinator does not replace workers; it verifies their isolation, reads their state, checks outputs, manages round boundaries, and decides whether to dispatch, pause, integrate, or escalate.

This skill complements `dispatching-parallel-agents`: use that skill to create independent workers; use this one to supervise long-lived worker threads across rounds.

For completion governance, verification sufficiency, "why not do it" challenges, or decisions about whether local work should continue versus block, use `autonomous-development-governor` first. Return to this skill when the decision requires worker/thread/worktree mechanics.

## When To Use

Use when the user provides or implies:

- Multiple Codex thread/session IDs or a request to create them.
- Role boundaries such as A/B/C ownership.
- Independent worktrees or a need for data isolation.
- A shared output root, dispatch documents, or round-based delivery.
- Heartbeats, recurring polling, blockers, or cross-checks.

Do not use for a single-thread task, one-off code review, or ordinary subagent execution inside the current session.

## Plan Mode Decision Gate

When in Plan mode, invoke this skill before finalizing a detailed plan if the work may have two or more independent domains. Do not create worker threads or dispatch documents before the development plan exists and the user confirms the collaboration mode.

After the development plan is drafted, evaluate whether multi-session division of labor is warranted and what worker count would be most efficient:

- Prefer single-session execution when the plan is small, linear, low risk, or dominated by one module.
- Recommend multi-session coordination when the plan has separable domains, long-running work, parallelizable research and implementation, separate frontend/backend/infrastructure tracks, independent worktrees, or review/integration risk.
- Estimate the optimal worker count, not the maximum possible count. Choose the smallest number of workers that meaningfully reduces elapsed time without creating coordination overhead.
- State the recommendation, worker count, proposed role split, and reason in one short paragraph.
- Ask the user to confirm whether to proceed with multi-session coordination and the suggested worker count before creating workers, dispatch files, automations, or worktrees.

## Worker Count Assessment

Use this heuristic after reading the completed development plan:

1. List the independent workstreams that can produce useful output without waiting on each other.
2. Remove workstreams that are mostly sequential prerequisites, require the same files, or would force frequent cross-worker edits.
3. Add one integration/review lane only when there are at least two implementation workers and cross-checking or merge risk is meaningful.
4. Default to 1 worker for small or linear plans, 2 workers for two clearly separable tracks, 3 workers for three tracks or two tracks plus integration, and 4 workers only when four domains are truly independent.
5. Recommend more than 4 workers only when the plan has strong isolation, separate worktrees or artifacts, explicit output contracts, and low merge overlap.
6. If the ideal count is uncertain, recommend the lower count for the first round and leave expansion as a later option.

Output the assessment in this compact shape:

```text
Coordination recommendation: <single-session | multi-session>.
Suggested workers: <N>.
Role split: A=<scope>, B=<scope>, C=<scope>...
Reason: <why this count is faster than fewer workers and safer than more workers>.
```

Use this confirmation prompt, adapting only the first sentence to the project:

```text
我评估这个开发计划后，建议启用多会话协同，并使用 <N> 个 worker：<role split>。是否按这个分工推进？你也可以指定改为其他人数。
```

If the user accepts, proceed with Worker Creation Preflight and dispatch according to the confirmed division of labor. If the user changes the worker count, revise the role split before dispatch. If the user declines, proceed with single-session execution and do not create workers.

## Worker Creation Preflight

Before creating or forking workers, verify the project target. Do not trust a saved project name alone.

1. Resolve the intended repository root from the user's path, the current thread cwd, or an existing known-good project thread.
2. Run non-destructive checks in that exact directory: `git -C <path> rev-parse --show-toplevel` and `git -C <path> status --short`.
3. If a saved project points at a non-git directory or the wrong repository, do not create workers from it. Fork a known-good thread that is already attached to the real repository, or ask the user for the correct project target.
4. Prefer detached worktrees for concurrent code work unless the user explicitly requests shared-local execution.
5. If worktree creation returns only a pending id, follow Pending Worktree Fallback Gate before dispatching.
6. After creation, read each worker thread and verify its cwd and git status before sending scoped work.

Never put two workers in the same checkout for overlapping code changes.

## Thread Tool Availability Check

Before saying worker thread creation is unavailable, inspect the available thread tools for `create_thread`, `fork_thread`, `send_message_to_thread`, `list_threads`, and `read_thread`.

- If direct thread creation exists, use it to create one worker thread per assigned worktree.
- If only same-directory fork or send-message exists, use the best supported binding path and then verify cwd before dispatch.
- If no thread creation or messaging tool is available, write the exact missing capability in the coordinator status and produce copy-ready worker prompts as a last resort.

Do not stop at "create the worktrees and ask the user to open sessions" unless the tool check proves there is no supported way to create, fork, or message worker threads.

## Pending Worktree Fallback Gate

When `fork_thread` or `create_thread` returns `pendingWorktreeId` instead of a child `threadId`, use the official path briefly, then stop waiting and fall back.

1. Record `pendingWorktreeId`, source thread id, intended repository root, intended branch or starting state, expected worker label, and expected worktree path if known.
2. Poll `list_threads` every 15 seconds for at most 60 seconds.
3. For each plausible child thread, call `read_thread` and verify the thread cwd, assigned worktree/path, and recent git status before treating it as the worker.
4. If no verified child thread exists after 60 seconds, mark the pending fork as unreliable and switch to Manual Worktree Fallback. Do not keep polling just because the pending id still exists.
5. Do not inspect or edit Codex internal state files to infer pending failure reasons. Treat unavailable pending logs as unavailable.

Do not send substantive worker tasks to a pending id. `pendingWorktreeId` is not a worker thread id.

## Manual Worktree Fallback

Use this path when pending worktree setup exceeds the 60 second gate or repeatedly fails without exposed diagnostics.

1. Verify the real repository root:

```powershell
git -C <repo> rev-parse --show-toplevel
git -C <repo> status --short
```

2. Create one isolated worktree per worker, using predictable names:

```powershell
git -C <repo> worktree add <worktree-path> -b coord/<topic>/<role>
```

If the branch already exists, append a short id: `coord/<topic>/<role>-<shortid>`.

3. Create or direct each worker thread to the exact manual worktree directory. If the thread tool cannot bind directly to that directory, stop dispatch and ask for a thread attached to that path.
4. Before sending any real task, read the worker thread and verify its cwd equals the assigned worktree. If cwd does not match, do not dispatch.
5. In every fallback dispatch, state that the official pending worktree path was abandoned and that all writes must stay inside the manual worktree.

## Worker Thread Dispatch Gate

Creating worktrees and dispatch documents is preparation, not worker startup. A worker is not started until a thread exists, its cwd is verified, and its scoped prompt has been sent.

For each worker:

1. Create or identify the thread attached to the assigned worktree.
2. Read the thread and verify cwd equals the assigned worktree.
3. Run or request the worker preflight: `git status --short`.
4. Send only that worker's scoped dispatch, including forbidden areas, output path, validation commands, approval posture, and stop gates.
5. Record `threadId`, `worktree_created`, `thread_created`, `cwd_verified`, `dispatch_sent`, and current status in the worker registry.

Do not use the user as a prompt router. If a worker prompt must be copied manually because tools are unavailable, present it as a fallback blocker with the minimum user actions required, not as a completed startup.

## Pre-Implementation Fact Check

Before dispatching implementation workers, perform a short read-only fact check when the task depends on existing behavior, ambiguous naming, configuration flow, runtime state, external integrations, or a user-reported contradiction.

Use the coordinator locally or assign a small explorer task first. The goal is to remove unverified assumptions before implementation begins.

Run this gate when:

- the user reports that the system behaves differently from what the UI or settings imply
- a field name, file name, endpoint name, or label may be historical, compatibility-only, or misleading
- the behavior crosses multiple layers such as UI, API, storage, runtime configuration, background jobs, or external services
- multiple workers could make conflicting assumptions about the same behavior
- a dynamic value could be mistaken for a fixed constant

The fact check should identify:

- the source of truth for the behavior or value
- the actual data flow across relevant layers
- names that are only labels, legacy terms, or implementation details
- values that must remain dynamic or user-controlled
- files, functions, or modules that own the behavior
- assumptions that are still unverified and must not be given to implementation workers

Do not dispatch implementation work from surface names alone. If the fact check finds ambiguity, either resolve it through more read-only inspection or pass the uncertainty explicitly into the worker prompt with a stop condition.

Implementation worker dispatches should include only verified facts, clear ownership boundaries, allowed write areas, forbidden assumptions, validation commands, and acceptance criteria.

## Required Setup

Before coordinating, identify:

- Worker sessions: ID, label, role, worktree/path, expected output files.
- Worker startup state: worktree created, thread created, cwd verified, dispatch sent, running/completed/blocked.
- Shared output root: all coordinator and worker artifacts must go there.
- Round number and current dispatch document.
- Hard boundaries: actions that stop automation and require user confirmation.
- Resume condition: what evidence is required before dispatching the next round.
- Approval posture: whether the user granted automatic non-destructive execution, and which operations still require human confirmation.

If any of these are missing, infer conservatively from local files and thread history; ask the user only when a wrong assumption could cause unsafe work.

## Approval Handling

Thread tools may not expose approval or sandbox settings. When `create_thread` or `fork_thread` has no approval-policy field, do not claim tool-level auto-approval was configured.

Instead, put the user's approval posture in every worker dispatch:

```text
Approval posture: The user authorized automatic execution for routine, non-destructive reads, edits, builds, tests, and local worktree writes in this delegated thread. Do not ask for confirmation for those normal actions. Stop and ask only for destructive git/filesystem operations, production deployment, real secrets or paid external calls, cross-worker scope changes, or changes outside the assigned worktree.
```

If the app or tool schema later exposes an explicit approval-policy parameter, prefer the real tool setting and still include the written approval posture for clarity. If a worker is still blocked by approval prompts, send a narrowly scoped follow-up that repeats the approval posture instead of broadening the task.

Do not edit Codex internal state files to force approval policy changes. Treat app state as diagnostic evidence only. Real approval changes must come from the app UI, supported tool parameters, or an explicit user-approved configuration change.

## Coordination Loop

1. Read each worker thread status and latest output.
2. List expected files in the shared output root.
3. If any assigned worker has a worktree but no verified thread or dispatch, finish Worker Thread Dispatch Gate before claiming the round has started.
4. If every worker is still running, write a short status note and do not dispatch.
5. If some workers are complete and others are running, record partial completion, do not interrupt active workers, and evaluate Idle Worker Micro-Task Gate before dispatching any early work.
6. If all workers are complete, read all expected outputs and cross-check:
   - role boundary compliance
   - required files
   - validation results
   - unsafe claims or actions
   - conflicts between worker outputs
7. If safe and actionable, generate:
   - `ROUND_N_<topic>_CROSS_CHECK_AND_NEXT_PLAN.md`
   - `DEVELOPMENT_ROUND_(N+1)_DISPATCH.md`
8. Send each worker only its own scoped task, with inputs, forbidden areas, validation commands, and exact output path.
9. If work cannot continue without user input, generate the input checklist and pause dispatch.

## Idle Worker Micro-Task Gate

During heartbeat or manual polling, an idle worker may receive a very small early task only when it improves throughput without changing the overall round plan. Treat this as optional capacity use, not as permission to start the next round.

A worker is idle only if its current dispatch is complete, the thread is not running or blocked, its cwd is still verified, and it has no pending review, unsafe dirty work, or unresolved stop condition. A pending fork, approval-blocked worker, or worker with unreviewed output is not idle.

Before sending an idle micro-task, all of these must be true:

- The task can finish in one short pass and has a single narrow output.
- The work stays inside the worker's confirmed role, worktree, and allowed write set.
- The task does not depend on unfinished outputs from active workers.
- The task does not modify shared contracts, schemas, migrations, dependency files, lockfiles, routing roots, global config, or integration files unless it is explicitly read-only.
- The task is unlikely to conflict with active workers by file path or domain boundary.
- The output will help the current integration, next planning step, validation, documentation, or risk reduction.
- The prompt includes a stop condition, exact output path, and instruction to stop if the task appears larger than expected.

Prefer read-only or artifact-only micro-tasks:

- audit the worker's own domain for TODOs, missing tests, UI gaps, docs gaps, or acceptance risks
- run a targeted smoke check and report command output
- draft a small checklist or verification note under the shared coordination output root
- inspect likely conflict files and summarize risks without editing them
- prepare a tiny, scoped fix only when it touches files no active worker owns and does not change public contracts

Do not use idle micro-tasks to:

- start the next full feature or round
- implement assumptions about unfinished worker outputs
- broaden a worker into another role
- fix another worker's failing work
- perform merge, integration, dependency, migration, or release work
- create large docs or broad refactors that would distract from the main round

Use this compact dispatch shape:

```text
Idle micro-task for Round <N>; this is not the next round.
Worker: <label> / <threadId> / <worktree>
Purpose: <one sentence>
Allowed work: <narrow scope and allowed files or artifact path>
Forbidden work: no cross-role changes, no shared contracts, no dependency or lockfile changes, no assumptions from unfinished workers.
Stop if: the task needs more than one short pass, touches forbidden files, depends on active workers, or reveals a blocker.
Output: write/report <exact path or final response shape> with evidence.
```

Record idle micro-tasks in the worker registry with `status=idle_microtask`, `parent_round`, `micro_task_id`, `allowed_writes`, `output_path`, and completion evidence. When all primary workers finish, review micro-task outputs as supporting evidence only; they do not replace the normal cross-check or integration gate.

## Stop Conditions

Stop automatic advancement and write a risk or blocker report if any worker:

- fails, stalls with an error, or omits a required output file
- reports validation failure without an accepted follow-up plan
- crosses role boundaries
- proposes or performs destructive git operations
- creates overwrite or merge conflicts
- reaches a user/environment gate that cannot be solved locally
- leaks or requests secrets, tokens, raw prompts, production payloads, or paid external calls outside the approved scope

Also stop on domain-specific hard boundaries supplied by the user.

## Safety Boundaries Template

For API relay, billing, payment, or production-like systems, default to these boundaries unless the user explicitly replaces them:

- no production launch
- no real production payment funds flow
- no real upstream production keys
- no public registration launch
- no automatic renewal
- no unsupported financial aggregation claims
- no migration-complete claims without evidence
- no new funds ledger unless explicitly approved
- no estimating missing usage or silently charging
- no caching prompts, responses, tool outputs, file context, full keys, upstream keys, or raw payment payloads

Use the user's project-specific boundary wording in generated dispatches.

## Dispatch Prompt Pattern

Each worker prompt should include:

- source coordinator thread ID, if available
- worker label, role, and exact scope
- worker-specific worktree/path
- worker thread id and cwd verification status, if already available
- files to read before designing
- preflight commands: confirm cwd, run `git status --short`, and report unexpected dirty files
- fallback status if the worker uses a manual `git worktree add` directory
- approval posture and stop gates
- forbidden areas and data-safety rules
- required validation commands
- final output path or final response requirements

Never ask a worker to perform another worker's scope. Never ask active workers for new work before the current round completes.

Use this preflight block in every code worker dispatch:

```text
First do:
1. Confirm cwd equals the assigned worktree.
2. Run `git status --short`.
3. Report any unexpected dirty files before editing.
4. Keep all writes inside the assigned worktree unless explicitly told otherwise.
```

## Automation Handling

For heartbeat automations:

- Inspect existing automations before creating a new heartbeat; update a matching heartbeat instead of creating duplicates.
- Include worker thread IDs, labels, worktree paths, current round, stop gates, and latest integration rule in the automation prompt.
- Keep the heartbeat attached to the coordinator thread when the user wants the same conversation to continue managing the project.
- Keep notifications quiet while no user action is needed.
- Notify only when advancing a round, hitting a blocker, needing user input, or stopping automation.
- During each heartbeat, if some workers are idle while others are still running, evaluate Idle Worker Micro-Task Gate. Dispatch at most one micro-task per idle worker per heartbeat, and only if it is safe, useful, and clearly smaller than a normal round task.
- If automation would keep polling a known user-input blocker, pause or delete it and explain how to resume.
- Do not leave a stale heartbeat running just to restate the same blocker.

## Resuming After User Input

When the user provides environment details or other blockers:

1. Validate that inputs are non-production unless explicitly approved.
2. Redact secrets in docs and chat.
3. Generate a small preflight plan before worker dispatch.
4. Dispatch only the workers whose scopes can make progress.
5. Keep unavailable scopes marked `pending`; do not coerce them into `pass`.

## Integration Gate

Before integrating worker changes into the main checkout:

1. Confirm every worker thread is complete, not merely that files exist on disk.
2. Read each worktree's `git status --short` and diff.
3. Check overlap by file path and domain boundary.
4. Protect the main checkout's dirty worktree; do not overwrite or revert user changes.
5. Run targeted tests first, then broader regression if the changes touch shared contracts.
6. Only commit or push after the integrated tree is verified and the user asked for that step.

## Common Mistakes

- Dispatching the next round while one worker is still `inProgress`.
- Treating a file appearing on disk as completion when the worker thread has not finished.
- Creating workers from an unverified saved project that points to a non-git or wrong directory.
- Assuming `create_thread` configured auto-approval when the tool schema has no approval field.
- Sending work before verifying the child thread's actual cwd and git status.
- Claiming workers are started when only worktrees and dispatch files exist.
- Making the user copy worker prompts when thread creation or messaging tools are available.
- Declaring thread tools unavailable without checking the available thread tool surface.
- Treating `pendingWorktreeId` as a worker thread id.
- Waiting indefinitely for a pending worktree fork instead of switching to Manual Worktree Fallback after 60 seconds.
- Dispatching substantive work to a fallback worker before verifying its cwd equals the manual worktree.
- Continuing automation after the project is blocked on user-provided environment inputs.
- Letting a worker broaden its role because another worker is idle.
- Treating idle capacity as permission to start the next round or modify shared contracts before active workers finish.
- Writing "passed" for evidence that is only a command template or pending prerequisite.
- Embedding project-specific thread IDs inside reusable instructions.
