---
name: architect
description: Design an important implementation boundary before coding. Use for meaningful API, package/module, ownership, state-machine, data-model, persistence, or concurrency decisions where design clarity is valuable before implementation.
---

# Architect

Design the important shape of `<work-id>` without implementing it.

Use this skill selectively. Normal tickets do not need an architecture phase.

## Focus

Resolve the aspects that materially affect correctness or long-term structure, such as:

- ownership and responsibility boundaries;
- package/module placement;
- public/internal interfaces;
- domain model and invariants;
- state transitions;
- concurrency ownership and lifecycle;
- persistence boundaries;
- data/control flow across components;
- failure and cancellation semantics.

Ground the design in the existing repository rather than designing an idealized greenfield system.

## Output

Present the proposed design and its important trade-offs to the user.

If a decision is settled, make it explicit so `/handoff` can capture it later.

Do not write production implementation code.
Do not expand into a broad architecture rewrite outside the requested change.

## Exit condition

Stop when the important design decisions are clear enough to be handed off for implementation.
