---
name: review
description: Perform a bounded, adversarial code review against the ticket, approved plan, diff, and repository behavior. Use to find concrete correctness, regression, failure-mode, and edge-case bugs without turning review into an open-ended style or refactoring exercise.
---

# Review

Try to prove the implementation is wrong.

Review is a separate engineering activity from implementation. Prefer a fresh reviewer so it does not inherit the implementer's assumptions.

The goal is not to produce many comments. The goal is to find **real defects that could matter in production**.

## Review boundary

Review the change against:

1. the ticket/request and acceptance criteria;
2. the approved plan, when one exists;
3. repository-local instructions and established behavior;
4. the diff against the intended base and relevant surrounding code;
5. tests and validation relevant to the changed behavior.

Do not assume the implementation is correct because tests pass.

Do not expand review into unrelated cleanup, style preference, architecture redesign, or speculative future work.

Do not modify production code during the initial review pass.

## Local work artifacts

For `<work-id>`, write the review to:

```text
.work/active/<work-id>/review.md
```

If an approved plan exists at:

```text
.work/active/<work-id>/plan.md
```

read it before reviewing.

Optional `investigation.md`, `wayfind.md`, or files under `investigations/` are supporting context. Read them only when needed to understand intent or verify a finding.

`.work/` should normally be gitignored.

## Fresh-review principle

Prefer a reviewer that did not implement the change.

Give the reviewer:

- the ticket or requested behavior;
- the approved plan, if present;
- the diff against the intended base;
- relevant surrounding code and tests.

Avoid providing the implementation conversation unless it contains required context missing from the ticket or plan.

The reviewer should independently reconstruct whether the change is correct.

## Risk classification

Classify the change before reviewing.

### Low

Typical examples:

- small isolated change;
- straightforward existing pattern;
- no persistence, concurrency, security, external contract, or migration risk.

Default:
- one adversarial review pass;
- verify only uncertain findings.

### Medium

Typical examples:

- meaningful business logic;
- multiple modules;
- non-trivial error handling;
- persistence or external integration behavior;
- meaningful regression surface.

Default:
- one adversarial review pass;
- verify all BLOCKER and IMPORTANT findings.

### High

Typical examples:

- concurrency;
- authentication or authorization;
- tenant isolation;
- data migration or integrity;
- payments or financial calculations;
- queues, retries, idempotency, or distributed workflows;
- public API or cross-service contract changes;
- security-sensitive input handling;
- destructive operations.

Default:
- one core adversarial review;
- optionally one specialist review for the dominant risk area;
- verify all BLOCKER and IMPORTANT findings.

Do not inflate risk merely because the diff is large.

## Core review lenses

Always inspect the following.

### Intent and requirements

Ask:

- Does the implementation actually satisfy the ticket?
- Are acceptance criteria missing or only partially implemented?
- Did the implementation add behavior that was not requested?
- Did it reinterpret an agreed plan decision?

### Correctness

Look for:

- incorrect branches or state transitions;
- off-by-one and boundary errors;
- nil/null/empty/zero behavior;
- stale or inconsistent state;
- incorrect assumptions about callers or callees;
- partial-success bugs;
- ordering mistakes;
- incorrect defaults;
- violated invariants.

### Failure paths

Actively inspect:

- returned and ignored errors;
- retries;
- timeout and cancellation behavior;
- partial writes;
- cleanup paths;
- rollback behavior;
- resource lifecycle;
- failure after an earlier step has already succeeded.

### Regression and compatibility

Ask:

- What existing caller could this break?
- What existing behavior changed unintentionally?
- Are old data, old clients, old events, or previous states still supported where required?
- Did an interface, schema, or contract change without all consumers being updated?

### Test quality

Do not merely count tests.

Ask:

- Do the tests exercise the important behavior?
- Could the implementation be meaningfully wrong while these tests still pass?
- Are failure paths and edge cases represented where risk justifies them?
- Are mocks hiding an integration assumption?
- Is the test asserting the real observable outcome?

## Risk-specific lenses

Apply only when relevant.

### Concurrency

Look for goroutine/task leaks, races, deadlocks, lock-order issues, channel lifecycle mistakes, lost cancellation, closure capture, duplicate work, ordering assumptions, and shutdown bugs.

### Persistence and databases

Look for transaction-boundary errors, partial writes, uniqueness assumptions, read-modify-write races, migration compatibility, nullable/default behavior, isolation assumptions, stale reads, and destructive update/delete scope.

### Queues and distributed systems

Look for duplicate delivery, idempotency gaps, retry amplification, poison messages, ordering assumptions, partial completion, timeout ambiguity, at-least-once assumptions, missing deduplication, and unsafe retries of non-idempotent operations.

### Authentication, authorization, and tenancy

Look for missing authorization, trust in caller-controlled fields, tenant leakage, confused-deputy behavior, role/permission mismatches, insecure defaults, and authentication state crossing the wrong boundary.

### External APIs and services

Look for missing timeout/cancellation, incorrect retries, malformed/partial responses, pagination, rate limits, version assumptions, non-idempotent retries, and incorrect status/error-code handling.

### Frontend asynchronous state

Look for stale responses, double submission, loading/error transition bugs, optimistic rollback mistakes, unmounted updates, request races, and cache invalidation mistakes.

## Finding standard

A BLOCKER or IMPORTANT finding must describe a **concrete failure scenario**.

Every such finding must include:

- **Location** — where the problem occurs.
- **Failure scenario** — input/state/sequence that triggers it.
- **Why it is a bug** — the incorrect observable result.
- **Evidence** — relevant code path, contract, test gap, or repository behavior.
- **Suggested correction** — the smallest reasonable direction, not a rewrite.
- **Confidence** — high, medium, or low.

If you cannot explain how the code can actually fail, do not raise the issue as BLOCKER or IMPORTANT.

Prefer one strong root-cause finding over several symptoms of the same problem.

## Severity

Use only:

### BLOCKER

A credible defect involving correctness, data integrity, security, major availability risk, or a serious violation of requirements.

Should not merge without resolution.

### IMPORTANT

A credible bug, regression, meaningful edge case, or reliability issue worth addressing before merge.

### NOTE

Sparse, non-blocking information that genuinely helps the engineer.

Do not use NOTE for style, naming, formatting, subjective refactoring preferences, or speculative extensibility.

## Explicit non-goals

Do not report:

- formatting handled by tooling;
- naming preferences without correctness impact;
- "could be cleaner" refactors;
- abstractions for hypothetical future requirements;
- broad architecture rewrites outside the ticket;
- unrelated pre-existing defects unless this change materially worsens or depends on them;
- duplicate variants of the same root cause.

## Verification of findings

AI review findings are hypotheses until verified.

After the initial review, verify each BLOCKER and IMPORTANT finding before asking for code changes.

Classify each as:

- **CONFIRMED** — repository evidence supports the failure scenario.
- **DISPROVED** — surrounding behavior, contracts, or tests show the scenario cannot occur.
- **NEEDS HUMAN DECISION** — the issue depends on product intent or an architectural decision that cannot be inferred safely.

Verification may include:

- tracing callers/callees;
- inspecting related tests;
- running a focused test;
- reproducing the scenario;
- checking schema/configuration/contract behavior.

Do not preserve disproved findings merely because the original reviewer sounded confident.

## review.md structure

Write:

```markdown
# Review — <work-id or change title>

## Verdict
PASS | CHANGES REQUIRED | HUMAN DECISION REQUIRED

## Risk
LOW | MEDIUM | HIGH

## Confirmed findings

### R1 — BLOCKER | IMPORTANT
...

## Needs human decision
...

## Disproved findings
Only initially plausible findings useful to retain during this review cycle.

## Validation
Checks or focused reproductions run during review.
```

Omit empty sections.

A review with no confirmed BLOCKER or IMPORTANT findings should say `PASS`.

## Fix cycle

When fixes are authorized, give the fixing worker only the confirmed findings and necessary context.

After fixes, perform **one delta review**.

The delta review checks only:

1. whether each confirmed finding was resolved;
2. whether the fix introduced a directly related regression;
3. whether the changed lines reveal another issue in the same affected behavior.

Do **not** restart a full open-ended review of the entire branch.

## Convergence rule

The default maximum is:

- one full adversarial review;
- one verification pass;
- one fix cycle;
- one delta review.

After the delta review:

- if findings are resolved, stop;
- if a serious issue remains, report it to the user;
- if a materially new design problem appears, escalate rather than beginning an unlimited review/fix loop.

Do not "review until zero findings."

## Orchestration

When an orchestrator is available:

- use a fresh worker for the full adversarial review;
- for medium/high-risk work, use a separate verifier when practical;
- for high-risk work, optionally run one specialist reviewer in parallel with the core reviewer;
- deduplicate findings before presenting them;
- send only confirmed findings to the fixing worker;
- run one delta review after fixes;
- bring unresolved product/design decisions back to the human.

Do not let orchestration mechanics alter the review standard.

## Completion rule

Review is complete when:

- the implementation received the appropriate adversarial review for its risk level;
- BLOCKER and IMPORTANT findings were verified;
- authorized fixes received at most one delta review;
- unresolved material issues were surfaced clearly.

Stop there.

Review is a bounded quality gate, not an autonomous search for perfection.
