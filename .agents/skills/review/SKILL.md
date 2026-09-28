---
name: review
description: Perform a rigorous fresh-context adversarial review whose purpose is to find and verify real defects that should prevent the code from being merged. Continue review, fix, and re-review iterations as long as needed to reach a reliable conclusion.
---

# Review

Try to prove the implementation is wrong.

This is the strongest quality gate in the workflow.

The objective is **not** to produce many comments. The objective is to find **real correctness, reliability, security, compatibility, or requirement defects that justify blocking merge in the implementation's current state**.

A confident-sounding AI concern is not a finding until it survives verification.

## Fresh-review principle

Prefer a reviewer that did not implement the change and does not inherit the implementation conversation.

For `<work-id>`, read:

- the ticket/request and acceptance criteria;
- repository-local instructions;
- `.work/active/<work-id>/plan.md` when present;
- the diff against the intended base;
- relevant surrounding code, tests, schemas, contracts, and configuration.

Use prior investigation artifacts only when needed to understand intent or verify a finding.

The reviewer should independently reconstruct whether the implementation is correct.

During an adversarial review pass, do not modify production code. First establish and verify the defects. Keeping diagnosis separate from repair reduces the chance that the reviewer becomes invested in defending its own patch.

## Review boundary

Review the change against:

1. requested behavior and acceptance criteria;
2. settled decisions in `plan.md` when present;
3. existing repository behavior and invariants;
4. public/internal contracts affected by the change;
5. realistic failure paths and operating conditions;
6. relevant tests and runtime verification.

Do not assume the implementation is correct because tests pass.
Do not assume a suspicious code pattern is a bug without a credible failure scenario.

## What counts as a serious finding

A merge-blocking finding must describe a **concrete failure scenario**.

For every serious finding capture:

- **Location** — where the defect exists.
- **Trigger** — the input/state/sequence/operating condition that activates it.
- **Observable failure** — what becomes incorrect from the system or user's perspective.
- **Why this violates requirements or invariants**.
- **Evidence** — code path, contract, schema, focused reproduction, test, runtime behavior, or other repository evidence.
- **Suggested correction direction** — the smallest reasonable direction, not a rewrite.
- **Confidence** — high, medium, or low before verification.

If you cannot explain how the implementation can actually fail, do not raise it as a merge-blocking defect.

Prefer one root-cause finding over multiple comments that describe symptoms of the same defect.

## Severity

Use only:

### BLOCKER

A credible defect involving correctness, data integrity, security, serious availability/reliability risk, or a material violation of requirements that should prevent merge.

### IMPORTANT

A credible bug, regression, compatibility issue, meaningful edge case, or reliability defect that should normally be resolved before merge.

### NOTE

Sparse, genuinely useful non-blocking context.

Do not use NOTE for style, formatting, naming taste, generic cleanup, speculative extensibility, or subjective refactoring preferences.

## Core adversarial lenses

Always inspect these areas where relevant.

### Intent and requirements

Try to find cases where the implementation:

- only partially satisfies the requested behavior;
- silently changes behavior outside the request;
- contradicts an agreed decision;
- misses an acceptance criterion;
- implements the happy path while leaving a required failure path incorrect.

### Correctness and state

Actively look for:

- wrong branches or state transitions;
- boundary/off-by-one errors;
- nil/null/empty/zero-value mistakes;
- stale or inconsistent state;
- violated invariants;
- incorrect ordering assumptions;
- incorrect defaults;
- partial-success bugs;
- unsafe assumptions about callers, data shape, or lifecycle.

### Failure paths

Trace what happens when operations fail before, during, or after side effects.

Look for:

- ignored/incorrectly wrapped errors;
- unsafe retries;
- missing timeout/cancellation propagation;
- partial writes and missing rollback/cleanup;
- resource leaks;
- ambiguous success after timeout;
- failure after an earlier step already committed state;
- failure paths that tests or mocks accidentally hide.

### Regression and compatibility

Ask what existing caller, client, event, stored row, state, configuration, migration phase, or deployment ordering can break.

Do not evaluate compatibility only against newly written code.

### Tests

Ask whether the tests would still pass if the implementation were meaningfully wrong.

Look for:

- mocks that encode the implementation's assumption rather than the real contract;
- missing failure/edge behavior;
- tests asserting internal calls instead of observable outcomes;
- coverage that does not exercise the changed branch;
- integration assumptions that unit tests cannot prove.

## Frontend / UI runtime review

When the change affects user-visible frontend behavior and the application is runnable, independently exercise the changed functionality through the real UI using an approved browser/automation mechanism.

Do not treat unit tests, snapshots, typechecking, or the implementer's own manual verification as sufficient independent evidence.

Where relevant, inspect:

- the intended user flow;
- loading, empty, disabled, validation, and error states;
- navigation and state transitions;
- stale/duplicate/async behavior;
- browser console errors;
- network requests/responses that materially affect correctness.

Use a repository-specific verification skill when one exists. If the changed UI cannot be exercised because required browser/runtime access is unavailable, record the verification gap and determine whether it prevents a reliable PASS.

## Blast-radius / safety-claim review

For meaningful changes, identify the important assumptions on which the safety of the change depends.

Examples:

- "all callers pass a tenant-scoped identifier";
- "this operation is never retried after a side effect";
- "no old client sends the removed field";
- "only one goroutine can mutate this state";
- "this migration always runs before the new binary".

Try to move each important claim through increasingly strong evidence:

```text
assumption
→ code/reference evidence
→ caller/failure-path trace
→ focused executable test or reproduction
→ real runtime proof when practical
```

A safety claim that cannot be established is itself a reason to investigate further. Do not automatically convert uncertainty into a finding; determine whether the unsafe scenario is actually reachable.

## Risk-adaptive depth

Classify the change informally by risk and adjust review depth accordingly.

High-risk areas include:

- concurrency and async coordination;
- authentication, authorization, and tenant isolation;
- migrations, persistence, and data integrity;
- payments/financial calculations;
- queues, retries, idempotency, and distributed workflows;
- destructive operations;
- public APIs and cross-service contracts;
- security-sensitive parsing/input handling;
- rollout/rollback compatibility.

High-risk changes deserve deeper tracing, more executable verification, and specialist review when useful.

Do not inflate risk merely because the diff is large.

## Specialist reviews

When the dominant risk warrants it and the environment supports multiple fresh agents, dispatch focused reviewers such as:

- concurrency/lifecycle;
- auth/security/tenancy;
- persistence/migration/data integrity;
- distributed-systems/retry/idempotency;
- contract/backward-compatibility;
- frontend async/cache/state behavior.

Give each specialist the same evidence standard: concrete failure scenarios, not a generic checklist dump.

The core reviewer must synthesize and deduplicate their output. Multiple reviewers repeating the same concern increases confidence but does not create multiple findings.

## Verification of findings

Initial review findings are hypotheses.

Before presenting BLOCKER or IMPORTANT findings as real, verify them using the strongest reasonable evidence available.

Verification may include:

- tracing callers/callees and state transitions;
- reading related tests, schemas, migrations, contracts, and configuration;
- executing a focused test;
- writing a minimal reproduction;
- exercising the real runtime surface;
- using a repository-specific verification skill;
- checking deployment or compatibility assumptions.

Classify candidate findings as:

### CONFIRMED

The failure scenario is supported by repository or runtime evidence.

### DISPROVED

Further evidence shows the scenario cannot occur or the behavior is correct.

Remove disproved issues from the final blocking set.

### NEEDS HUMAN DECISION

The issue depends on product intent, acceptable risk, or an architectural decision that cannot be established from evidence.

Do not disguise a missing product decision as a code defect.

## Fix and re-review loop

Review is **not capped to one fix cycle or a fixed number of passes**.

When confirmed findings are authorized to be fixed:

1. hand only the confirmed defects and necessary evidence to the fixing context;
2. prefer a separate implementation/fix agent when the environment supports it;
3. fix the confirmed defects;
4. re-run the reproduction or evidence that demonstrated each defect where practical;
5. perform another adversarial review, preferably from a fresh reviewer/context;
6. inspect whether the fix introduced a directly related regression or exposed another real defect;
7. continue the cycle for as many iterations as necessary to reach a reliable result.

A later pass may broaden again when the fix materially changes control flow, contracts, state ownership, or blast radius. Do not artificially restrict every pass to only the exact lines from the prior finding when that would miss realistic regressions.

At the same time, do not create an endless review loop by lowering the evidence threshold on later passes.

Every new serious issue must still meet the same concrete-scenario and verification standard.

## When to stop

Stop only when one of these is true:

### PASS

After review appropriate to the change's risk, there are no remaining **known, confirmed BLOCKER or IMPORTANT defects**, and important safety claims have enough evidence to make the result reliable.

PASS does not mean "perfect" or "proved bug-free". It means the implementation survived a rigorous adversarial review and there is no known reason it should be blocked from merge.

### CHANGES REQUIRED

One or more confirmed BLOCKER or IMPORTANT defects remain unresolved.

### HUMAN DECISION REQUIRED

A material unresolved question depends on product/architecture/risk intent and further technical review cannot decide it safely.

Do not stop because an arbitrary iteration count was reached.
Do not continue merely to manufacture more findings after the evidence has converged.

## Explicit non-goals

Do not report as merge blockers:

- formatting handled by tooling;
- naming/style preferences without correctness impact;
- generic "could be cleaner" refactors;
- abstractions for hypothetical future requirements;
- unrelated architecture redesign;
- speculative risks with no credible reachable scenario;
- pre-existing defects unrelated to the change unless the new change depends on, exposes, or worsens them materially.

Quality comes from finding the bugs that matter, not maximizing issue count.

## Review artifact

Write the current review state to:

```text
.work/active/<work-id>/review.md
```

Use this structure:

```markdown
# Review — <work-id>

## Verdict
PASS | CHANGES REQUIRED | HUMAN DECISION REQUIRED

## Risk
LOW | MEDIUM | HIGH

## Confirmed findings

### R1 — BLOCKER | IMPORTANT
- Location:
- Failure scenario:
- Observable result:
- Evidence:
- Suggested correction:

## Needs human decision
...

## Disproved findings
Only initially plausible issues worth retaining to explain review reasoning.

## Validation performed
- Focused checks, tests, reproductions, runtime verification.

## Review iterations
- Iteration 1: ...
- Iteration 2: ...
```

Omit empty sections except Verdict, Risk, and Validation performed.

Keep the artifact updated across fix/re-review iterations so a fresh reviewer can understand what has already been proven, disproven, fixed, and revalidated.

## Final standard

The review is complete when the result is reliable enough to answer the real engineering question:

> Is there any known, evidence-backed reason this change should not be merged in its current state?

If yes, report it clearly and keep it blocked.
If no after appropriate adversarial scrutiny, PASS.
