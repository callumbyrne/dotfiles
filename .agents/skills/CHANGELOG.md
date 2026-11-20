# Changelog

## v6

A focused adjustment to the v5 readability pass; all other engineering gates remain intact.

- `/refine` now starts with a **cold reading of the diff**, without first reading the request, `plan.md`, or implementer notes. It checks the surrounding context and contracts **after** identifying potential comprehension barriers, before editing.
- Clarified that **descriptive naming is the first priority, not the only allowed improvement**. Targeted reorganisation, helper changes, and flow simplification are appropriate when they genuinely reduce cognitive load; cosmetic restyling is not.
- Updated `/deliver` to preserve this cold-read context boundary in the refiner's initial prompt. No extra worker, report artifact, or review loop was added.
- Kept `/review`, `/implement`, global instructions, installer, and other skills unchanged from v5.

## v5

A targeted readability improvement to the proven v4-with-deliver workflow.

- Added `/refine`, a fresh-context, behaviour-preserving readability pass focused first on descriptive identifier naming, then local reasoning, control flow, and organisation.
- Updated `/implement` to self-check code clarity before handoff, rather than relying on the refiner for basic hygiene.
- Updated `/deliver` to run `/refine` once before the first correctness review for meaningful code changes; skip it for obviously readable trivial changes. Validation after refinement is required when code changes.
- Kept `/review` as the independent, adversarial correctness gate with its existing unlimited evidence-backed fix/re-review loop. Refinement is not another merge blocker or indefinite style loop.
- Added `global/CLAUDE.md` with focused readability guidance. It is provided for manual comparison/merging and is **not** automatically installed over existing global instructions.
- Updated README and installer to include the new skill.

## v4

Major simplification of the framework around current frontier-model capability.

### Changed

- Renamed `plan` to `handoff`.
- `handoff` now focuses only on converting shared conversational context into a fresh-context execution contract.
- Simplified `explore` into a conversational understanding phase rather than a heavyweight research process.
- Simplified `implement`; removed generic software-engineering advice and automatic feature/refactor playbooks.
- Promoted evidence-first debugging into a standalone `bugfix` skill.
- Removed `wayfind` from the default framework; `/explore` plus normal parallel agents covers the same need with less ceremony.
- Removed `arena` and `swarm` as permanent skills; treat them as Herdr orchestration patterns instead.
- Kept `architect` as an optional design-only skill.
- Kept `create-verification` as the repository-specific procedure generator.

### Review

`review` is now explicitly the strongest quality gate in the framework.

- It remains adversarial and aims to find real merge-blocking bugs.
- Serious findings must describe concrete failure scenarios and be verified.
- False positives must be actively disproved and removed.
- Review is risk-adaptive and may use specialist reviewers for high-risk changes.
- There is no fixed iteration cap. Fix/re-review cycles continue as long as needed to reach a reliable conclusion.
- The review must still avoid style noise, speculative refactors, and low-confidence issue generation.

## v4 deliver addition

- Added `/deliver`, a Herdr-based autonomous coordinator for end-to-end task delivery.
- Added one-task-worktree, `request.md`, and `state.json` conventions for resumable autonomous execution.
- `/deliver` preserves fresh contexts between exploration/handoff, implementation, review, and fix/re-review phases.
- Added explicit material-decision escalation rules so routine engineering choices do not interrupt the user.
- Added mandatory real UI/browser verification for runnable frontend changes during implementation and independent review.
- Updated `/review` with an explicit frontend/UI runtime-review requirement.
- Added `deliver` to the Claude installer.
