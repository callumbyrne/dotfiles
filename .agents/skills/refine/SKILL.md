---
name: refine
description: Improve the readability, naming, local comprehensibility, and organisation of changed code without changing behaviour. Use after implementation and before adversarial correctness review, or independently when a user requests a focused readability pass.
---

# Refine

Make the changed code easier for another engineer to understand **without reconstructing the implementer's reasoning**.

This is a focused readability pass, not a second implementation, a correctness review, or a general refactoring campaign. The objective is less cognitive load, not more changes.

## Scope and context

Prefer a fresh context that did not write the implementation. Work on the same task checkout; do not create another branch or worktree. If invoked without a work ID, use the explicitly requested files or diff.

**First pass — read cold.** Inspect the task diff against its intended base and relevant repository conventions **before reading** the task request, `plan.md`, implementer notes, or implementation conversation. If needed, obtain the base/diff from Git or the coordinator without receiving an explanation of the change. Read the code as an unfamiliar maintainer, with normal local context (types, imports, adjacent lines), and note *potential* comprehension barriers. Do not mistake a legitimate need to understand a domain concept or contract for bad readability.

**Second pass — verify context.** After the independent first read, consult the request, `.work/active/<work-id>/plan.md` when present, surrounding declarations/callers, and contracts as needed. Determine which potential issues are genuinely avoidable and which edits are safe. Established domain vocabulary and repo conventions outrank personal naming preferences. Do not change code based solely on an initial impression.

Limit edits to the changed code and directly affected local declarations/callers. Do not alter unrelated code merely because its style is imperfect. The user's explicit scope and repository conventions take precedence over personal taste.

## Cold-reader test

For every meaningful new or modified function, variable, type, and flow, ask:

> Can a reader understand its responsibility and meaning from its name, type, and immediate context, without opening several other functions or holding an entire call chain in their head?

Prioritise issues that meaningfully slow comprehension, **with naming as the first priority rather than an artificial limit**:

1. **Naming and intent.** Use precise domain vocabulary. Make non-obvious data shape, units, ownership, booleans, side effects, and return meaning apparent where helpful. Prefer descriptive names over vague ones such as `data`, `result`, `process`, or `handle` when the surrounding context does not establish their meaning.
2. **Local reasoning.** Keep related logic together when that improves understanding. Reduce needless jumping between helpers, hidden state, ambiguous transformations, and distant dependencies.
3. **Control flow.** Simplify avoidable nesting, conditions, branches, and long functions when a smaller coherent structure is materially easier to follow.
4. **Organisation and abstractions.** Give modules/functions one clear responsibility, but resist wrappers, tiny single-use helpers, speculative abstractions, and new layers that make the reader navigate more code.
5. **Consistency.** Follow repository idioms, existing domain terminology, and language conventions. Concise names like `err`, `ctx`, loop indices, or short Go receiver names are good when their meaning is obvious locally; length is not the goal.

Prefer code that explains *what* it does through names and structure. Comments should explain non-obvious *why*, constraints, or invariants—not compensate for unclear code.

## Edit threshold and safety

Make a change only when you can explain how it improves comprehension for a future maintainer. A merely different naming preference is not enough.

**Choose the smallest coherent improvement that meaningfully reduces cognitive load.** Start with clearer names when they solve the problem, but do not stop there when confusing organisation, indirection, or control flow is the real cause. Reorganising code, combining or extracting a helper, or simplifying flow is appropriate when it materially improves local understanding; do not do it merely to enforce a preferred style or a different-looking implementation. Avoid both unnecessary renaming and unnecessary restructuring. The expected diff should be proportionate to the readability benefit.

- Preserve observable behaviour, API and data contracts, error semantics, ordering, concurrency, resource lifecycle, and test intent.
- Avoid renaming public/exported interfaces, serialized fields, reflection-dependent names, database identifiers, or symbols used across boundaries without explicitly verifying compatibility; report risky opportunities instead.
- Do not change architecture, business rules, dependencies, or unrelated files. Do not turn this pass into opportunistic feature work or broad formatting churn.
- Prefer targeted edits over large rewrites. If code is already readable, make no changes and say so.
- If a proposed simplification could affect behaviour or requires a material design decision, leave it unchanged and report the concern. Do not claim to have validated behaviour merely by reading it.

## Execution

1. Read the diff cold before reading the plan, request, or implementer notes. Flag only plausible, avoidable comprehension barriers—not every moment that requires thought.
2. Consult the request, plan, surrounding code, and contracts to verify the concerns and the safety of possible edits.
3. Identify the few highest-impact improvements; consider descriptive naming first, then structural changes when naming alone would not solve the problem.
4. Apply the smallest cohesive improvements, updating necessary local references. Do not force a change when existing code is clear.
5. Inspect the resulting diff for scope expansion, accidental semantic changes, and needless churn.
6. Run relevant formatting, static checks, and focused tests for affected code. Re-run functional verification when an edit could affect the exercised runtime path and a runnable verification route is available. If a check fails, fix or revert the refinement, rather than passing a known regression onward.

Do not require a new `.work/` artifact or create a separate readability scorecard. Do not manufacture findings to justify this phase.

## Completion

Report concisely:

- what materially improved (or that no worthwhile changes were needed);
- validation actually run and any inability to validate;
- any substantial readability concern deliberately left unchanged due to scope or compatibility risk.

The subsequent `/review` remains the **sole adversarial merge-quality gate**. A refinement pass does not declare the branch merge-ready and does not replace `/review`.
