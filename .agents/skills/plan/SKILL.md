---
name: plan
description: Turn an understood ticket or completed exploration into a concise, disposable implementation plan. Use when decisions are settled enough for a fresh implementation context or worker to execute the change without reconstructing the discussion.
---

# Plan

Create the **execution handoff** for a change.

A plan records decisions that have already been made. It is not the place to restart discovery or redesign the feature.

## Planning boundary

This skill authorizes planning only.

- Do not implement project code.
- Do not perform opportunistic refactors.
- Do not expand scope beyond the supplied ticket and agreed discussion.
- Do not create multiple planning documents unless the work genuinely needs decomposition into separate independently executable units.

The default output is **one concise plan**.

Plans are disposable execution artifacts. They may be archived or deleted after the implementation is complete. Durable architectural knowledge should be captured separately in the repository's established documentation or ADR process when appropriate.

## Plan location

Store plans in the repository-local temporary workspace:

```text
.work/active/<work-id>/plan.md
```

Use the ticket identifier when one exists, for example:

```text
.work/active/DATA-421/plan.md
```

If there is no ticket identifier, use a short, stable kebab-case slug:

```text
.work/active/improve-session-refresh/plan.md
```

`.work/` should normally be gitignored. It is a local engineering workspace, not permanent repository documentation.

If `.work/` does not exist, create only the directories needed for the current work. Do not add `.work/` to version control unless the user or repository explicitly requires it.

If a related optional investigation artifact exists at:

```text
.work/active/<work-id>/investigation.md
```

use it as input, but synthesize the agreed decisions into `plan.md` rather than requiring the implementation worker to read the exploration history.

## When a plan is useful

Create a plan when one or more of these are true:

- implementation will happen in a fresh context or by another worker;
- the change has several coordinated steps;
- there were meaningful decisions during exploration that should not be reconstructed;
- requirements or constraints are easy to accidentally miss;
- the change crosses multiple components;
- parallel or orchestrated execution needs a clear contract.

If the work is already obvious and small, say that a separate plan is unnecessary rather than adding ceremony.

## Inputs

Use, in order:

1. the ticket/request and acceptance criteria;
2. decisions explicitly agreed with the user;
3. findings from exploration;
4. repository conventions and existing implementation patterns.

Inspect the codebase enough to ensure the plan is grounded in reality, but do not reopen settled design decisions merely to create more discussion.

If new evidence materially contradicts an agreed decision, stop and surface the conflict.

## Plan quality

A good plan is:

- specific enough that a fresh worker can execute it;
- concise enough to read before coding;
- explicit about requirements and constraints;
- ordered where sequencing matters;
- clear about validation;
- free of speculative implementation detail that the worker can safely determine locally.

Prefer references to concrete modules, packages, endpoints, tables, jobs, or tests when known.

Avoid line-number-level instructions unless the exact location is important and stable.

## Writing the plan

When this skill is asked to create a plan, write the plan to `.work/active/<work-id>/plan.md` unless the user explicitly requests another location.

If a plan for the same work already exists, update that plan rather than creating parallel versions such as `plan-v2.md`.

The file is the canonical implementation handoff for that work item.

## Required structure

Use this structure unless the repository has an established equivalent:

```markdown
# <ticket or change title>

## Goal
What the change achieves and why it exists.

## Requirements
- Required behavior.
- Constraints that must remain true.
- Relevant acceptance criteria.

## Approach
The agreed implementation approach and the important decisions behind it.

## Tasks
- [ ] Concrete implementation unit.
- [ ] Concrete implementation unit.
- [ ] Tests and/or validation work.

## Validation
How to verify the change is correct.

## Out of scope
Anything easy to confuse with this change that is intentionally excluded.
```

Add `## Risks / notes` only when it carries information the implementer genuinely needs.

Omit empty sections rather than filling them with boilerplate.

## Task design

Tasks should describe meaningful implementation units, not keystrokes.

Good tasks:

- are independently understandable;
- have a clear completion condition;
- mention sequencing or dependencies when needed;
- include testing/validation at the appropriate point;
- follow vertical behavior where practical rather than arbitrary architectural layers.

Do not force TDD. Testing strategy should follow repository conventions and the risk of the change.

## Decisions vs implementation freedom

Capture decisions that are important to correctness or scope.

Leave ordinary coding choices to the implementer when they can be made safely from repository conventions.

The plan should prevent unnecessary redesign without micromanaging routine implementation.

## Handoff

When the plan is intended for a fresh context or worker, ensure it contains everything that worker must know without access to the prior conversation.

The implementer should not need the exploration transcript to understand:

- the goal;
- the requirements;
- the chosen approach;
- the important constraints;
- the work to perform;
- how to validate it.

## Completion rule

Planning is complete when a competent engineer or agent could begin implementation without having to reconstruct the earlier discussion.

After writing the plan, report its path.

Stop after presenting or writing the plan. Do not proceed into implementation unless separately instructed.
