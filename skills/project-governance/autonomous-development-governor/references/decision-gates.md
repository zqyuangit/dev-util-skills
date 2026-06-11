# Decision Gates

Load this reference when deciding whether a development task can continue, should be blocked, or may be declared complete.

## Doable-vs-Blocked Gate

Classify every unfinished item before stopping.

Doable locally:

- Unit, integration, component, or source-level tests
- Builds and type checks
- Docker compose rebuild/start/health checks
- Local API smoke checks
- Browser/Playwright smoke checks against local services
- Reading logs, diffs, configs, migrations, schemas, and docs
- Updating docs or reports to match verified local evidence

Blocked or approval-gated:

- Real production credentials or secrets
- Paid external calls not explicitly approved
- Production deployment or public launch
- Destructive git/filesystem actions
- Customer/private data access outside the repo
- External providers that require user-owned accounts, keys, allowlists, or billing
- Decisions that change product scope beyond the user's plan

Rule: if an item is locally doable, do it or plan to do it next. Do not list it as a passive caveat in a final answer.

## Evidence Ladder

Report evidence at the highest level actually reached:

1. Source evidence: files, diffs, schemas, contracts inspected
2. Unit/component evidence: targeted automated tests passed
3. Build evidence: production build/type check/package succeeds
4. Runtime evidence: services start, health checks pass, APIs respond
5. Browser evidence: real UI flow verified with browser automation or screenshots
6. External integration evidence: real third-party provider or production-like integration verified

Do not use a lower level to imply a higher level. For example, unit tests do not prove browser typewriter output; mock SMS does not prove a real SMS provider.

## Completion Gate

Before saying "complete" or "done":

- All planned local implementation items are implemented or explicitly descoped by the user.
- All local doable validation items have run, passed, or been reported as failed with next action.
- Documentation and reports match actual code and test evidence.
- Temporary artifacts are separated from deliverable code.
- Known user-visible risks are fixed, tested, or explicitly accepted.
- External blockers list exact missing input and why local work cannot substitute for it.

If any local doable item remains, the status is not done. It is either `implementing` or `verifying`.

## Reality Drift Gate

Trigger this gate when docs, tests, API references, UI labels, or final summaries no longer match code.

Required action:

- Identify the source of truth.
- Update docs/reports or correct the implementation.
- Avoid "planned", "done", "skeleton", and "verified" wording unless evidence supports it.
- Record unverified claims as unverified instead of deleting them silently.

## User-Visible Risk Gate

Elevate issues that learners, admins, judges, or customers can see:

- Raw stack traces, API names, ports, framework names, internal enum values
- Infinite loading or polling states
- Success messages without actual success
- Broken or misleading copy
- Stale progress/accuracy/account data
- Missing visible feedback after slow actions

Treat these as high-priority even if they are small code changes.

## External Dependency Gate

External blockers must include:

- Provider/system name
- Exact missing input, such as test key, sandbox account, allowlist, callback URL, or billing approval
- What was verified locally instead
- What command or flow should run after the input is available

Never fake external evidence with mocks.
