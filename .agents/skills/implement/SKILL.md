---
name: implement
description: Implement a clear ticket or an approved implementation plan while respecting repository conventions, scope, and validation requirements. Use when the work is sufficiently understood and planning decisions should be treated as settled.
---

# Implement

Build the requested change.

Implementation consumes an understood ticket or an approved plan. It should not casually reopen decisions that have already been made.

## Inputs and authority

Treat these as authoritative, in order:

1. explicit user instructions;
2. product requirements and acceptance criteria in the supplied ticket;
3. an approved implementation plan, when one exists;
4. repository-local instructions and established conventions;
5. existing code and tests.

The repository is authoritative about current reality. If the approved plan assumes something that is demonstrably false in the codebase, surface the conflict rather than blindly following it.

## Local work artifacts

The default location for a planned change is:

```text
.work/active/<work-id>/plan.md
```

When invoked with a ticket/work identifier and no explicit plan path, check for that plan before starting broad investigation.

For example:

```text
DATA-421
→ .work/active/DATA-421/plan.md
```

If a plan exists, treat it as the implementation handoff.

An optional `investigation.md` or `wayfind.md` in the same workspace is supporting context, not automatically required reading. Read it only when the plan references it or implementation hits an ambiguity the plan does not resolve.

If no plan exists, implementation may proceed directly when the supplied ticket/request is sufficiently clear.

## Before coding

Read the ticket or plan and the minimum repository guidance required to work safely.

Briefly establish:

- what behavior is being changed;
- the intended approach, if planned;
- the validation expected;
- any sequencing constraints.

Do not restart broad exploration if the work is already well specified.

## Implementation principles

- Keep the change within the agreed scope.
- Follow existing repository patterns unless the plan explicitly changes them.
- Prefer existing abstractions over introducing unnecessary new ones.
- Make the smallest coherent change that satisfies the requirements.
- Preserve unrelated behavior.
- Avoid drive-by cleanup, dependency upgrades, renames, or refactors.
- Update comments or durable documentation only when the code change makes existing material inaccurate or when the plan explicitly requires it.
- Do not optimize for cleverness. Optimize for consistency, clarity, and maintainability in this codebase.

## Tests and validation

Testing is required when appropriate, but **test-driven development is not required**.

Choose tests based on:

- the repository's established testing practices;
- the behavior being changed;
- regression risk;
- the most useful seam for proving correctness.

During implementation:

- run targeted tests/checks frequently when useful;
- add or update tests that protect the changed behavior;
- prefer focused feedback loops before expensive full-suite checks.

Before completion, run the relevant broader validation available to you, such as:

- unit/integration tests;
- type checking;
- linting/formatting;
- build or compile checks;
- repository-specific validation commands.

Do not claim validation that was not actually run.

## When reality conflicts with the plan

Small implementation details can be resolved locally.

Escalate instead of silently changing direction when you discover something that materially affects:

- product behavior;
- API or data contracts;
- security or privacy;
- compatibility or migration strategy;
- architecture agreed in the plan;
- scope or acceptance criteria;
- another in-flight task.

When escalating, report:

1. what assumption or decision no longer holds;
2. the evidence;
3. the impact;
4. the smallest viable options.

Do not continue with a materially different design until authorized.

## Plan tracking

If the supplied plan contains tasks, use them as the implementation checklist.

When the plan lives at `.work/active/<work-id>/plan.md`, update its task checkboxes as work is completed unless the environment or orchestrator already owns task state. Avoid maintaining two competing trackers.

Do not create a new plan unless the user explicitly asks for replanning.

## Completion

Before declaring the work complete:

- confirm the requested behavior is implemented;
- confirm relevant tests/validation pass, or clearly report failures/limitations;
- inspect the final diff for accidental scope expansion;
- note any deliberate deviation from the plan;
- identify any follow-up that is genuinely required.

Report completion concisely:

### Implemented
What changed.

### Validation
What was run and the result.

### Deviations / follow-up
Only if applicable.

## Workspace lifecycle

The implementation plan is disposable unless the repository or user requires it to be retained.

Do **not** delete or archive the active workspace before the implementation has been reviewed or the user has indicated the work item is complete.

When cleanup is requested or completion policy is known, use one of:

```text
.work/active/<work-id>/
    ↓ archive
.work/archive/<work-id>/
```

or delete `.work/active/<work-id>/` entirely.

Archiving is the safer default when no repository-specific policy exists, but do not perform cleanup unless it is part of the requested workflow.

Durable lessons discovered during implementation should be moved into the repository's normal documentation/ADR system rather than preserved merely by keeping the temporary plan.
