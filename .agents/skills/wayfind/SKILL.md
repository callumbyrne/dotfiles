---
name: wayfind
description: Break down large or poorly understood work into decision-focused investigations. Use when the destination is known but important technical or product questions must be resolved before a credible implementation plan can exist.
---

# Wayfind

Map the unknowns before planning the build.

Wayfinding is for work where the desired destination is understandable, but the route is not yet clear enough to create a trustworthy implementation plan.

It produces **decisions and evidence, not implementation**.

## Wayfinding workspace

Persist wayfinding state in the repository-local temporary workspace:

```text
.work/active/<work-id>/
├── wayfind.md
└── investigations/
```

Use the ticket/initiative identifier when one exists. Otherwise use a short, stable kebab-case slug.

`.work/` should normally be gitignored.

`wayfind.md` is the canonical decision map. It should stay compact and current rather than becoming a chronological research log.

Create files under `investigations/` only when an investigation needs its own durable result, especially when:

- multiple workers/scouts are investigating in parallel;
- the result is too detailed for `wayfind.md`;
- another investigation depends on the evidence;
- the finding must survive a context boundary.

Example:

```text
.work/active/auth-migration/
├── wayfind.md
├── investigations/
│   ├── provider-capabilities.md
│   └── rollback-options.md
└── plan.md        # created later, once the route is clear
```

## Use wayfinding when

Use this skill when several of the following are true:

- the work is larger than one normal implementation context;
- the solution crosses multiple systems or ownership boundaries;
- important architectural choices are unresolved;
- feasibility is uncertain;
- migration, compatibility, rollout, or rollback strategy is unclear;
- several investigations can happen independently;
- a normal plan would currently contain vague tasks such as "investigate", "decide", or "figure out".

Do not use wayfinding merely because a ticket is large. If the approach is already known, create a plan and decompose the implementation instead.

## Core rule

A wayfinding item answers a question whose output is a **decision, constraint, or verified fact**.

It is not an implementation task.

Bad:
- "Build the new authentication adapter."
- "Refactor the repository."
- "Add the endpoint."

Good:
- "Can the new identity provider preserve the identifiers required by downstream systems?"
- "Where should migration state live?"
- "Can old and new authentication flows run concurrently during rollout?"
- "What rollback point is available after the schema transition?"

When an investigation starts turning into implementation, stop at the point where the decision is supported.

## Process

### 1. Define the destination

State what successful planning should make possible.

Examples:

- choose a migration strategy;
- produce an implementation plan;
- determine whether a proposed architecture is feasible;
- identify the safe rollout sequence.

The destination should describe the decision outcome, not the implementation itself.

### 2. Identify blocking unknowns

List only questions that materially block planning.

For each question capture:

- **Question** — what must be learned or decided?
- **Why it matters** — what planning decision depends on it?
- **Evidence needed** — code, docs, experiment, external constraint, stakeholder input, etc.
- **Depends on** — other questions that must resolve first, if any.
- **Output** — the decision/fact expected from the investigation.

Avoid a giant research backlog. Prefer the smallest set of unknowns that can clear the route.

### 3. Build the decision map

Show dependencies between investigations.

Example:

```text
Provider capability ─┐
                     ├─> Coexistence strategy ─> Migration approach
State ownership ─────┘

Rollback constraints ──────────────────────────┘
```

Identify the current **frontier**: questions with no unresolved dependencies that can be investigated now.

This frontier is the natural unit for parallel workers or scouts.

### 4. Investigate

Resolve frontier questions using the strongest available evidence.

Investigations may include:

- tracing current code;
- reading contracts or external documentation;
- inspecting data shape and usage;
- running safe experiments or prototypes;
- comparing established patterns;
- consulting a human when the uncertainty is product/organizational rather than technical.

Keep implementation changes out of the production codebase unless the user explicitly authorizes a disposable prototype for learning.

### 5. Record decisions

For every resolved question, capture:

- the decision or verified fact;
- supporting evidence;
- important trade-offs or rejected alternatives;
- consequences for later planning;
- any new question discovered.

New questions should be added only when they materially block the destination.

### 6. Recompute the frontier

As decisions resolve, identify newly unblocked investigations.

Continue until either:

- the route is clear enough to create a credible plan; or
- a human/product decision is required and further technical investigation will not resolve it.

## Output

Write and maintain the canonical decision map at:

```text
.work/active/<work-id>/wayfind.md
```

Maintain a compact decision map with this shape:

### Destination
What wayfinding is trying to make plannable.

### Decisions so far
- **Decision:** ...
  - Evidence: ...
  - Consequence: ...

### Open investigations
- **Question:** ...
  - Why it matters: ...
  - Depends on: ...
  - Evidence needed: ...

### Current frontier
Questions that can be investigated now, in parallel where appropriate.

### Blocked on human input
Only decisions that cannot be resolved through further investigation.

### Exit condition
What still needs to be true before normal planning can begin.

## Orchestration

When an orchestrator is available:

- dispatch independent frontier questions to separate read-only/scout workers;
- give each worker one clear decision question;
- ask workers for evidence and a recommendation, not implementation;
- synthesize their findings centrally;
- batch human questions when possible rather than interrupting for every uncertainty.

Do not allow workers to make product or architectural decisions beyond the authority given to them.

## Completion rule

Wayfinding is complete when there are no important unknowns preventing a credible implementation plan.

At that point, hand off to `plan` (or directly to `implement` if the effort turned out to be small).

If planning is needed, `plan` should create:

```text
.work/active/<work-id>/plan.md
```

alongside the wayfinding artifacts. The implementation worker should normally consume `plan.md`; it should not need to reconstruct decisions from every investigation file.

Do not continue from wayfinding straight into implementation merely because the route is now clear.
