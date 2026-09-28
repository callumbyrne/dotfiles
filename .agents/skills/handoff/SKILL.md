---
name: handoff
description: Distill the current shared understanding into a concise implementation handoff for a fresh agent context. Use after exploration or design discussion when decisions are settled enough to execute.
---

# Handoff

Create the execution contract for `<work-id>`.

Use the current conversation, explicit user decisions, ticket requirements, and repository findings already established.

The implementation agent may have **no access to this conversation**.

## Output

Write:

```text
.work/active/<work-id>/plan.md
```

Create the directory when needed.

The plan should contain only the information a fresh implementation agent needs:

```markdown
# <work-id> — <title>

## Goal
...

## Requirements / constraints
- ...

## Approach
Settled implementation direction and important decisions.

## Implementation
- Meaningful implementation unit.
- Meaningful implementation unit.

## Validation
- How the change should be proven correct.

## Out of scope
- Easy-to-confuse work intentionally excluded.
```

Add a short risks/notes section only when it materially helps execution.

## Compression rules

Capture:

- settled decisions;
- requirements easy to miss;
- important constraints and invariants;
- concrete modules/components when already known;
- validation expectations.

Do not include:

- exploratory dead ends;
- rejected ideas unless the rejection itself is an important constraint;
- the conversation transcript;
- routine coding instructions a capable implementation agent can infer from the repository.

Do not restart broad exploration merely to make the handoff more detailed.
If new repository evidence materially contradicts a settled decision, surface the conflict instead of silently rewriting it.

Do not implement production code.

## Exit condition

The handoff is complete when a fresh implementation agent can execute the change without access to the planning conversation.
