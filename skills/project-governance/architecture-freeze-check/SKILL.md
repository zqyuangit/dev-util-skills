---
name: architecture-freeze-check
description: Use when a project is about to move from idea or prototype into implementation and there is a risk of later large-scale redesign due to unclear roles, workflow, boundaries, or delivery structure.
---

# Architecture Freeze Check

## Overview

Run a short structural review before major implementation begins. The goal is to catch redesign risks early by freezing role boundaries, core user flow, delivery shape, and proof points before code scale makes changes expensive.

This skill complements existing planning skills:

- Use `brainstorming` when the idea is still fuzzy.
- Use this skill when the idea is mostly clear but the structure still needs a pre-implementation pressure test.
- Use `writing-plans` after this skill once the structure is stable enough to implement.
- Use `test-driven-development` after implementation starts.

## When to Use

Use this skill when:

- a project is about to leave prototype stage
- the repo already has some code, but the main product structure still feels unstable
- student side, admin side, API side, or data side may be mixed together
- the team keeps changing page hierarchy, role boundaries, or delivery approach
- requirements mention scoring, governance, publishing, evidence, or multiple user roles
- there is a risk that "we can build features now and organize later" will create expensive rework

Do not use this skill when:

- the structure is already frozen and the task is now implementation-only
- the request is a small isolated bugfix
- the system is still too vague to review structurally; use `brainstorming` first

## Workflow

1. Map the system in one screen
2. Pressure-test structural risk
3. Freeze the minimum architecture decisions
4. Refuse implementation until the risky decisions are explicit
5. Hand off to `writing-plans`

## Step 1: Map the System in One Screen

Create a compact map with only these fields:

- user roles
- primary user journeys
- pages or surfaces
- backend services
- data ownership
- publish or governance flow
- acceptance or scoring evidence

If you cannot fit this in a short table, the project is probably too fuzzy or too broad.

## Step 2: Pressure-Test Structural Risk

Review the project against these six redesign triggers:

### 1. Role Confusion

Ask:

- Does each user role have a distinct purpose?
- Is any page trying to serve both end users and operators?
- Are management actions leaking into the learner or customer flow?

### 2. Workflow Confusion

Ask:

- Can a new user understand the first action within a few seconds?
- Is there one primary journey, not several competing first steps?
- Are secondary functions pushed behind the main journey instead of crowding it?

### 3. Boundary Confusion

Ask:

- Do frontend, backend, admin, and content responsibilities have clear ownership?
- Is there a single source of truth for profile, plan, resource, and assessment state?
- Are legacy and new runtime paths both active without a clear migration boundary?

### 4. Content Governance Gap

Ask:

- Who creates, reviews, publishes, and updates knowledge or resource content?
- Can the learner side consume only published content?
- Is feedback routed back to the correct governance surface?

### 5. Delivery Gap

Ask:

- Can the system be explained as a product rather than a dev demo?
- Do the main screens map cleanly to the requirement or scoring points?
- Is there a stable demo path from entry to outcome?

### 6. Deployment or Runtime Drift

Ask:

- Are auth, ports, gateway, runtime entry points, and environment variables already drifting?
- Is there one recommended startup path?
- Are archive or legacy paths explicitly marked as non-mainline?

## Step 3: Freeze the Minimum Decisions

Before implementation, explicitly freeze these decisions:

- roles: who uses which surface
- main entry: first page and first action
- main flow: the one journey the demo must always support
- surface ownership: user side vs admin side vs internal tooling
- source of truth: which service owns each key state
- governance chain: who can publish and who can only consume
- acceptance mapping: which screen proves which requirement

If any item above is unresolved, do not call the structure "stable".

## Step 4: Produce the Freeze Brief

Write a short brief with these headings:

- Scope
- Roles
- Primary Flow
- Surface Boundaries
- Data Ownership
- Governance Flow
- Acceptance Evidence
- Frozen Decisions
- Open Risks

Keep it short. The point is commitment, not polish.

## Step 5: Decide the Next Skill

- If the project is still ambiguous, go back to `brainstorming`.
- If the structure is stable, move to `writing-plans`.
- If implementation already started and structure is wrong, pause new coding and redesign only the unstable boundary instead of rewriting everything.

## Output Standard

Good output from this skill should make these statements easy to answer:

- Who is this product really for?
- What is the default user journey?
- What belongs in the user-facing surface?
- What belongs in the admin or governance surface?
- Which service owns each critical state?
- How will the team prove requirement coverage?

## Common Mistakes

- Treating visual polish as the main redesign risk when the real problem is product structure
- Starting implementation before role boundaries are frozen
- Mixing learner, admin, and developer information in one interface
- Letting legacy and new runtime paths coexist without migration rules
- Mapping requirements to features but not to visible proof on real screens
- Freezing too much detail; this skill should freeze structure, not every UI choice

## Quick Reference

Use this skill to prevent:

- late separation of user and admin flows
- homepage and workspace purpose drift
- content generation without governance
- unstable deployment entry points
- scoring or requirement evidence gaps

This skill does not replace design or planning. It adds a freeze gate between them.
