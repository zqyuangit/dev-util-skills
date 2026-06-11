# Status Taxonomy

Use these terms consistently when governing development progress.

## States

- `planning`: requirements, scope, architecture, or acceptance criteria are still being decided.
- `implementing`: code, docs, tests, or scripts are being changed to satisfy the plan.
- `verifying`: implementation is present, and local evidence is being gathered or rerun.
- `blocked`: progress cannot continue without external input, unsafe approval, missing credentials, unavailable environment, or a failed dependency outside local control.
- `done`: all planned local work is complete, all locally doable verification has passed or been explicitly accepted, and only documented external blockers remain.

## Issue Categories

- `blocker`: prevents completion or safe continuation.
- `user_visible`: visible to a learner, admin, judge, or customer.
- `data_integrity`: affects ownership, isolation, transactions, migration integrity, or correctness of persisted data.
- `contract`: affects API shape, schema, public type, migration, or cross-service interface.
- `verification_gap`: local evidence is missing but can still be gathered.
- `external_dependency`: needs credentials, provider setup, public network, billing, or production-like integration.
- `documentation_drift`: docs, plans, reports, or screenshots no longer match implementation.
- `temporary_artifact`: logs, screenshots, test results, cache files, or local outputs that should not be committed unless requested.

## Evidence Labels

- `source`: file paths, diffs, schemas, configs, API contracts
- `test`: automated test command and result
- `build`: build/typecheck/package command and result
- `runtime`: local service/container/API health evidence
- `browser`: Playwright/manual UI evidence with route or screenshot
- `external`: real provider or production-like integration evidence
- `not_run`: intentionally not run, with reason
- `failed`: run and failed, with exact next action

## Final Status Rules

- Use `done` only when no local doable work remains.
- Use `blocked` only when the same remaining work requires external input or unsafe approval.
- Use `verifying` when code exists but tests, builds, runtime, or browser evidence still needs to run.
- Use `implementing` when a known local code/docs/test fix remains.
- Use `planning` when the next action depends on product or architectural choices.
