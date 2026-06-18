---
name: frontend-critical-flow-acceptance
description: Use when frontend changes touch critical user flows such as login, registration, modal dialogs, route transitions, form submission, stateful tab/resource selection, partial API payloads, default-to-first-item regressions, parent-child refresh synchronization, payment-like confirmation, exam submission, export/download, or fullscreen reading before claiming the work is done.
---

# Frontend Critical Flow Acceptance

## Overview

This skill prevents "tests pass but the user sees a grey screen / blank page / dead button" failures. It is a final interaction gate for frontend work, not a replacement for debugging, UI polish, unit tests, or build verification.

## When To Use

Use this after any change that affects:

- Login, registration, auth prompts, session recovery, account recovery, password reset, or first-use gates.
- Dialogs, drawers, popovers, overlays, fullscreen readers, or portals.
- Primary calls to action, route changes, form submit, exam submit, export, download, upload, or payment-like confirmation.
- Stateful selection flows where a child component selects an item and a parent refresh, polling callback, usage report, or background sync can overwrite that selection.
- Shared UI primitives that can affect many screens, especially Radix, Headless UI, shadcn-style wrappers, portals, z-index, focus traps, or scroll locks.

Do not use this for copy-only edits, pure docs changes, backend-only work, or broad visual design feedback. Use `frontend-ui-polish-specialist` for visual refinement, `systematic-debugging` for unknown bugs, `test-driven-development` for fixes, and `verification-before-completion` before final claims.

## Required Gate

Before saying a critical frontend flow is complete:

1. Identify the exact user path in plain language, for example "home question -> login modal -> login -> workspace with draft question".
2. Run normal verification first: relevant unit tests and production build.
3. Exercise the path in a real browser, preferably with Playwright or the app browser.
4. Verify user-visible outcomes, not just DOM existence.
5. Capture evidence: screenshot path, Playwright assertion output, or concise manual browser notes.

If step 3 is skipped, do not claim the flow is fixed or complete. Say what was verified and what still needs browser validation.

## Browser Acceptance Checklist

For each critical path, check the states that users actually experience:

- Visible: the expected screen, modal, panel, or result is visibly above overlays and not clipped.
- Clickable: primary and secondary buttons can be clicked and are not blocked by invisible layers.
- Recoverable: close, cancel, back, retry, or correction actions work.
- Responsive: one desktop viewport and one constrained viewport do not hide primary actions.
- Safe copy: no raw errors, API URLs, stack traces, framework names, ports, or developer-only wording leak to users.
- State preserved: drafts, answers, selected tabs, or submitted results remain when the flow promises they will.

Account recovery flows are default critical paths for password-login systems. Validate forgot password, reset password, invalid/expired token or code, return to login, and user-facing error/success copy whenever authentication work changes.

## Composite Flow Regression Gate

Do not treat component-level passing tests as proof that a user flow is safe when the flow crosses component or data boundaries.

Before claiming completion for a stateful flow:

1. Trace the full path from the user's click to the final visible state, including parent callbacks, background refreshes, polling, usage reporting, and cache writes.
2. Identify every place that can reset or replace local state, especially default-to-first-item logic after a refreshed list arrives.
3. Add or run at least one composite test or browser smoke that covers the whole chain, not just the leaf component.
4. Include a negative case: select a non-default item, non-first tab, non-recommended resource, or partially completed result, then trigger the refresh/sync that previously could overwrite it.
5. Verify the visible selection/result after the refresh completes.

Use this pattern for resource readers, practice review, chat draft handoff, route-driven panels, selected tabs, wizard steps, and any "click item -> fetch detail -> report usage -> refresh shell" workflow.

If only leaf tests were run, report them as leaf coverage and explicitly state that the parent-refresh composite flow is still unverified.

For async refresh flows, verify enqueue success, execution success, execution failure, worker absent, and the frontend polling stop condition. A refresh button or "queued" response is not sufficient evidence that the user will see a final state in local or demo environments.

## Partial Payload Regression Pattern

When a bug looks like "clicking item B jumps back to item A", do not assume the click handler passed the wrong id. First check whether a later refresh applies a smaller data set and default-selects the first item.

Trace these facts before fixing:

- Which user action sets the selected id.
- Which success callback, usage report, polling tick, cache invalidation, or parent refresh runs after that action.
- Whether the first refresh payload is a shell, daily subset, recommended subset, search result page, or otherwise partial list.
- Whether a later API returns the full list after the partial payload already changed selection.
- Whether fallback logic treats "selected id missing from this partial payload" as "selected item no longer exists".

Test the real data shape, not the convenient one:

- Mock the shell or parent-refresh endpoint as the smallest realistic subset.
- Mock the full-list endpoint separately and make it arrive after the shell data when that matches production order.
- Select a non-default item that is absent from the shell subset but present in the full list.
- Assert the final visible title, panel, tab, or detail remains the non-default item after all refreshes settle.
- Watch the test fail for the old bug before changing production code.

Use this whenever resource readers, tab panels, detail drawers, selected cards, step flows, or review screens combine local selection with parent-owned refreshed lists. A passing test that uses the full list for every endpoint does not prove this class of bug is fixed.

Portal and overlay flows require an extra layer check:

- Overlay has a lower z-index than content.
- Content has explicit positioning when rendered in a portal.
- Focus lands inside the visible content.
- `elementFromPoint()` at the center of the dialog hits dialog content, not the backdrop.

## Minimal Playwright Pattern

Use this style for a fast smoke check when no e2e test exists:

```js
const { chromium } = await import("@playwright/test");
const browser = await chromium.launch({ headless: true });
const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });
await page.goto("http://127.0.0.1:3001/", { waitUntil: "networkidle" });
await page.locator("#homeQuestion").fill("我想学习人工智能基础");
await page.locator(".home-send-button").click();
await page.locator(".home-login-dialog").waitFor({ state: "visible" });
const result = await page.evaluate(() => {
  const dialog = document.querySelector(".home-login-dialog");
  const overlay = document.querySelector(".ui-dialog-overlay");
  const center = document.elementFromPoint(window.innerWidth / 2, window.innerHeight / 2);
  return {
    dialogVisible: !!dialog && dialog.getBoundingClientRect().height > 0,
    dialogZIndex: dialog ? getComputedStyle(dialog).zIndex : "",
    overlayZIndex: overlay ? getComputedStyle(overlay).zIndex : "",
    centerClass: center?.className?.toString() ?? ""
  };
});
console.log(result);
await browser.close();
```

Adapt selectors and URLs to the project. Keep the check focused on the changed flow.

## Leader Rule For Multi-Worker Work

When integrating worker output, do not accept "tests pass" as sufficient for critical frontend flows. Require at least one of:

- A browser screenshot showing the final visible state.
- A Playwright smoke result for the changed path.
- A concise manual validation note with viewport, route, action, and observed result.

If a worker changed shared primitives, the leader must independently run one representative browser path before merging or reporting completion.

## Common Failure Modes

- Modal backdrop appears but content is behind it.
- Button click changes state but no visible feedback appears.
- Mobile viewport hides submit/register/export actions.
- Route navigation works only after refresh.
- Submitted answers/results disappear because live data refresh overwrites local review state.
- Download/fullscreen buttons open the wrong artifact.
- Clicking a non-default resource, tab, card, or detail row briefly works, then a partial parent payload defaults the view back to the first item.
- Account recovery flows exist in backend code but are unreachable because the visible entry, API helper, security allowlist, or error copy was missed.
- Async refresh stays pending forever when a worker absent condition is not handled.
