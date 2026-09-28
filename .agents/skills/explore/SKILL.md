---
name: explore
description: Investigate a requested change with the user to reach a shared understanding before implementation. Use when the problem, current behavior, constraints, or important design decisions are not yet sufficiently understood.
---

# Explore

Understand the work before building it.

The goal is a **shared understanding with the user**, not a code change and not yet a formal implementation handoff.

## Boundary

During exploration:

- inspect the repository and relevant behavior;
- trace the current implementation far enough to understand the change;
- identify important constraints, invariants, dependencies, and compatibility concerns;
- distinguish verified facts from assumptions;
- surface material product, architecture, API, data, security, migration, or scope decisions to the user;
- make recommendations when useful, with the evidence behind them.

Do not modify production code.
Do not silently make material decisions that the user should participate in.
Do not continue into implementation.

## Keep it conversational

Default to discussing findings with the user rather than creating documents.

Only persist an investigation when the work is large enough that important evidence would otherwise be lost or when multiple fresh agents will need the findings.

When useful, write:

```text
.work/active/<work-id>/investigation.md
```

Keep it compact and evidence-focused.

## Exit condition

Exploration is complete when:

- the requested behavior is understood;
- the relevant current behavior is understood;
- important constraints are known;
- material decisions have been surfaced and sufficiently settled;
- a `/handoff` can produce a concise execution contract without reopening broad discovery.

Stop there unless the user explicitly asks for another phase.
