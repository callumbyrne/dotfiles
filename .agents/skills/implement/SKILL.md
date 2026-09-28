---
name: implement
description: Implement a normal feature or change, consuming the local handoff plan when present. Use when the requested behavior is sufficiently understood and the task is not primarily an evidence-first bug investigation.
---

# Implement

Implement `<work-id>`.

## Context contract

Before coding, read repository-local instructions and check for:

```text
.work/active/<work-id>/plan.md
```

If it exists, treat it as the execution contract produced from the prior shared context.

Do not casually reopen settled decisions or redesign the task from scratch.

If repository evidence materially contradicts the plan in a way that affects product behavior, scope, API/data contracts, security, migration strategy, or an important architectural decision:

1. stop the conflicting part of the implementation;
2. explain the contradiction and evidence;
3. surface the smallest reasonable options.

Routine coding details remain implementation freedom.

## Scope

Implement the requested behavior and preserve unrelated behavior.
Avoid unrelated cleanup or scope expansion.

Use repository conventions and the repository's normal validation workflow.
When a repository-specific verification skill exists, use it for runtime behavior that it covers.

## Completion

Before reporting completion:

- inspect the final diff for accidental scope expansion;
- run the relevant validation available to the repository;
- do not claim checks that were not run;
- note any deliberate deviation from `plan.md`.

Do not rewrite the handoff unless the user explicitly asks for replanning.
