---
name: explore
description: Investigate a ticket, feature, bug, or technical problem before implementation. Use to understand existing behavior, constraints, unknowns, and viable approaches without changing project code.
---

# Explore

Act as an engineering thinking partner. Understand the work before deciding how to implement it.

Exploration is for **investigation and discussion, not implementation**.

## Goals

- Understand what the ticket or request is actually asking for.
- Ground the discussion in the current codebase and repository documentation.
- Explain the relevant existing behavior and architecture.
- Separate observed facts, assumptions, open questions, and decisions.
- Identify constraints, dependencies, risks, and likely affected areas.
- Compare viable approaches when a meaningful choice exists.
- Reach enough shared understanding to either implement directly, create a plan, or wayfind further.

## Boundaries

By default:

- Do not edit project source code.
- Do not start implementing the requested change.
- Do not create a plan artifact unless the user explicitly asks to plan or capture the agreed approach.
- Do not turn every uncertainty into a question for the user. Investigate anything the repository can answer first.
- Do not invent product requirements, acceptance criteria, or architectural constraints.
- Do not broaden the scope simply because adjacent cleanup looks attractive.

Read-only commands, searches, tests, logs, and other non-destructive investigation are allowed when useful.

## Temporary workspace

The shared local workspace for disposable engineering artifacts is:

```text
.work/
  active/
  archive/
```

`.work/` should normally be gitignored.

Exploration is conversational by default and should **not** create files merely to preserve a transcript.

If investigation results need to survive the current context before a plan can be created, write only the useful findings to:

```text
.work/active/<work-id>/investigation.md
```

Use the ticket identifier when one exists (for example `DATA-421`). Otherwise use a short, stable kebab-case slug.

`investigation.md` is optional and disposable. Do not create it when the conversation itself is sufficient.

## Sources of truth

Use this precedence when reasoning:

1. Explicit user instructions and current ticket requirements.
2. Repository-local instructions and established team documentation.
3. Existing code, tests, schemas, API contracts, and configuration.
4. Relevant historical context such as nearby implementations or version-control history.
5. Your own inference.

If these sources conflict, surface the conflict rather than silently choosing one.

## Process

### 1. Orient

Read the supplied ticket/request and the minimum repository guidance needed to work safely.

Identify:

- the user-visible or system-visible behavior being changed;
- explicit acceptance criteria;
- stated constraints;
- terms or domain concepts that need grounding.

### 2. Trace the current system

Inspect the relevant path through the codebase.

Prefer tracing behavior end-to-end over reading files broadly. Depending on the work, this may include:

- entry points and handlers;
- domain/service logic;
- persistence or external integrations;
- configuration and feature flags;
- tests that encode current behavior;
- error handling, telemetry, and background processing.

Explain what matters. Do not dump a repository tour.

### 3. Find the real decision points

Classify findings as:

- **Observed** — directly supported by the repository or supplied context.
- **Assumed** — plausible but not yet verified.
- **Open** — requires investigation or a human/product decision.
- **Decided** — explicitly agreed during this exploration.

Look especially for:

- unclear requirements;
- multiple plausible implementation approaches;
- compatibility or migration concerns;
- interactions with other in-flight work;
- hidden operational constraints;
- places where the requested behavior conflicts with existing patterns.

### 4. Discuss options

When there is a meaningful choice, present the smallest useful set of options.

For each option, focus on trade-offs that matter to this codebase: complexity, consistency, migration cost, failure modes, observability, performance, operational risk, and future maintenance.

Do not manufacture alternatives when one approach is clearly established by the repository.

### 5. Converge

As the discussion progresses, keep track of decisions already made. Do not repeatedly reopen settled points unless new evidence invalidates them.

When enough is known, recommend one of:

- **Implement directly** — the change is clear and small enough that another planning artifact would add little value.
- **Plan** — the approach is agreed, but a disposable handoff/checklist would make implementation safer or allow a fresh worker/context.
- **Wayfind** — important uncertainty remains and the work is too broad or interconnected to resolve as one exploration.

If `investigation.md` exists and planning is next, treat it as supporting evidence rather than as the implementation contract. The plan should contain the decisions the implementer actually needs.

## Output

Keep the exploration conversational while work is ongoing.

When asked to summarize, or when the exploration reaches a natural stopping point, use this shape:

### Current understanding
A concise explanation of the relevant current behavior and the requested change.

### Key findings
Only the findings that materially affect implementation.

### Decisions
Decisions explicitly agreed during the discussion.

### Open questions
Only unresolved questions that cannot reasonably be answered by further repository investigation.

### Recommended next step
`implement directly`, `plan`, or `wayfind`, with a brief reason.

## Completion rule

Exploration is complete when there is enough shared understanding to choose the next action.

Do not continue investigating merely to make the exploration feel exhaustive.
