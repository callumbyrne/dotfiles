---
name: deliver
description: Autonomously coordinate a work item from exploration through handoff, fresh-context implementation, rigorous adversarial review/fix loops, and runtime verification until the branch is ready for the user's final review. Use inside Herdr when the user wants end-to-end delivery with human interruption only for material decisions.
---

# Deliver

Own `<work-id>` from the user's request until the task branch is ready for the user's final review.

You are the **coordinator**, not the product-code implementer. Use fresh worker agents for engineering phases and Herdr for process/worktree management.

The desired user experience is:

```text
user gives task
→ autonomous exploration
→ ask user only when a material decision is genuinely required
→ handoff artifact
→ fresh implementation context
→ runtime verification
→ fresh adversarial review
→ fresh fix contexts for confirmed findings
→ fresh re-review as many times as needed
→ notify user that the branch is ready for final review
```

Do not merge, land, deploy, or push unless the user explicitly asks for that separately.

## Runtime requirement

This skill requires Herdr because fresh agent contexts are part of the correctness model.

Before coordinating:

1. confirm `HERDR_ENV=1`;
2. use the installed Herdr skill/instructions when available;
3. inspect `herdr --version` and the relevant command help before relying on CLI syntax;
4. do not guess pane, workspace, agent, or worktree identifiers;
5. prefer Herdr lifecycle waits over sleeps or prompt-character matching.

If Herdr is unavailable, stop and tell the user to run `/deliver` from a Herdr-managed agent rather than silently degrading to one long context.

Use the organization's approved agent harness. Do not switch model providers merely to diversify workers.

## Coordinator boundary

The coordinator may:

- create/reuse a task worktree and branch;
- create/update transient `.work/` artifacts;
- start, prompt, inspect, resume, and retire worker agents;
- run lightweight Git/Herdr inspection commands needed to coordinate;
- relay material questions and the user's answers;
- decide which workflow phase is appropriate from repository evidence.

The coordinator must not:

- edit production code itself;
- perform the implementation in its own context;
- perform the substantive adversarial review in its own context;
- silently make material product/architecture/security/migration decisions;
- merge, land, deploy, or push by default;
- treat an implementer's self-assessment as the final quality gate.

## Task workspace

Use **one task worktree** for the sequential delivery lifecycle.

All engineering workers for the task operate on that same checkout:

```text
explorer/handoff   read-only except .work artifacts
implementer        writes product code
reviewer           read-only during review
fixer              writes confirmed fixes
next reviewer      read-only during review
```

Fresh context means a **new agent process/context**, not a request for the previous worker to pretend it forgot its history.

If `/deliver` is already running inside an appropriate task worktree, reuse it.
Otherwise use Herdr's Git worktree support to create a task branch/check-out from the intended base.

Choose a conservative branch name derived from `<work-id>` and repository conventions when obvious. If the correct base branch or treatment of relevant uncommitted user changes is materially ambiguous, ask rather than risking work on the wrong base.

Never delete the task branch when cleaning up Herdr processes.

## Work artifacts

Inside the task worktree, ensure `.work/` is ignored locally and maintain:

```text
.work/active/<work-id>/
├── request.md
├── plan.md        # created by /handoff
├── review.md      # created/updated by /review
└── state.json
```

`investigation.md` may also exist when `/explore` needs to persist substantial evidence.

### request.md

Create `request.md` before spawning engineering workers.

It records the user's original task, acceptance criteria, and explicit constraints closely enough that a fresh reviewer can compare the final implementation against what was actually requested.

Do not replace the original request with the planner's interpretation.

### state.json

`state.json` is recovery metadata, not the source of truth for correctness.

Keep it small, for example:

```json
{
  "work_id": "DATA-123",
  "phase": "review",
  "status": "running",
  "review_iteration": 2,
  "branch": "DATA-123",
  "worktree": "/path/to/worktree"
}
```

Useful `phase` values are:

```text
setup
explore
implement
review
fix
ready_for_human_review
blocked
failed
```

Update it at phase transitions and before surfacing a blocking human decision.
Do not put secrets, full transcripts, or large worker outputs in it.

On resume, reconcile state with the actual Git checkout and artifacts. Do not blindly trust stale state.

## Human escalation standard

Autonomy is the default.

Workers should decide routine engineering details from requirements, repository conventions, tests, and evidence.

Bring a question to the user when it materially affects one or more of:

- product behavior or acceptance criteria;
- scope;
- public API or cross-service/data contracts;
- security, authorization, privacy, or tenant boundaries;
- destructive data behavior or migration strategy;
- rollout/rollback compatibility;
- an important architecture decision with materially different consequences and no established repository precedent;
- acceptance of a meaningful unresolved risk;
- missing credentials/access/tooling required to prove important behavior.

Do **not** interrupt the user for normal implementation choices such as helper placement, naming, ordinary private interfaces, or which established test fixture to reuse.

When escalation is needed, present one compact decision containing:

- the decision/question;
- why technical evidence cannot safely decide it;
- the relevant evidence;
- viable options and consequences;
- a recommendation when one is supportable.

Batch related decisions when practical.

After the user answers, relay the answer to the worker that owns the current phase and continue automatically.

## Phase 1 — Explore and hand off

Start a **fresh explorer agent** in the task worktree.

Its contract is:

1. read `request.md`, repository instructions, and relevant code;
2. run `/explore <work-id>`;
3. investigate autonomously and make routine evidence-backed decisions;
4. use a human question only for material decisions under the escalation standard;
5. do not edit production code;
6. once no unresolved material decisions block execution, run `/handoff <work-id>` **in the same agent context**;
7. ensure `.work/active/<work-id>/plan.md` exists and is sufficient for a fresh implementer;
8. report completion.

`/handoff` intentionally runs in the explorer's context because its job is to compress that accumulated understanding.

If the explorer becomes blocked, inspect the blocking question. If it meets the escalation standard, ask the user and resume the **same explorer context** with the answer.

Do not advance until the handoff exists and no unresolved material decision remains.

## Phase 2 — Fresh implementation

Start a **new agent context** in the same task worktree.

For a normal feature/change, instruct it to run:

```text
/implement <work-id>
```

For a task whose primary nature is an observed bug/regression requiring evidence-first diagnosis, use:

```text
/bugfix <work-id>
```

The worker must read `request.md`, `plan.md` when present, and repository-local instructions.

The implementation worker owns code changes and normal validation, but it does **not** decide whether the branch is merge-ready.

If it discovers repository evidence that materially contradicts the handoff, apply the human escalation standard rather than silently redesigning the task.

Do not proceed to review until implementation validation has completed or a concrete inability to validate has been surfaced.

## Runtime / functional verification

Prefer proof through the real runnable surface when practical.

When a repository-specific verification skill exists, use it.

For changes whose correctness depends on runtime behavior, validation should go beyond compilation/static analysis when the environment supports it.

### Frontend and UI changes

Frontend-impacting tasks require **actual functional verification** of the changed user flow.

The implementation phase should, using approved available tooling:

- start the relevant application/dependencies;
- open the real UI in a browser or browser automation environment;
- navigate to the changed functionality;
- exercise the intended flow like a user;
- inspect important loading/error/empty/disabled states when relevant;
- check browser console/network behavior when it materially affects correctness;
- capture enough evidence to explain what was exercised;
- clean up local processes/state safely.

Unit tests, snapshots, typechecking, and reading JSX/DOM code are not substitutes for real UI exercise when the changed behavior is runnable.

Use a repository verification skill, Playwright, or another organization-approved browser mechanism. Do not introduce a new unapproved external service merely for verification.

If no approved browser/runtime path is available and functional verification is important, treat that as a verification dependency and surface it to the user.

## Phase 3 — Fresh adversarial review

Start a **new reviewer context** in the task worktree after implementation completes.

Instruct it to read:

- `request.md`;
- `plan.md` when present;
- repository instructions;
- the full task diff against the intended base;

and run:

```text
/review <work-id>
```

The reviewer owns the merge-quality judgment.

It must follow the full `/review` evidence standard and update `review.md`.

For frontend/UI changes, the reviewer must independently exercise the changed functionality through the real UI when practical. Do not accept the implementer's browser verification as sufficient independent evidence.

The reviewer may dispatch fresh specialist read-only reviewers when the risk warrants it.

## Review result handling

Read the verdict from `.work/active/<work-id>/review.md` and reconcile it with the reviewer's output.

### PASS

Do not immediately merge.

Perform the final readiness checks below and then notify the user that the branch is ready for their final review.

### CHANGES REQUIRED

Only confirmed BLOCKER/IMPORTANT findings enter the fix loop.

Start a **fresh fixer agent** in the task worktree. Give it:

- `request.md`;
- `plan.md`;
- the confirmed unresolved findings and evidence from `review.md`;
- repository instructions.

Its contract is:

1. fix the confirmed defects without opportunistic redesign;
2. rerun the reproductions/evidence that demonstrated the defects when practical;
3. run appropriate focused and repository validation;
4. report completion;
5. do not declare the branch merge-ready.

After fixes, start another **fresh reviewer context** and run `/review <work-id>` again.

There is **no fixed maximum review/fix iteration count**.
Continue while the review process is finding and verifying real merge-blocking defects.
Do not lower the evidence threshold merely to keep the loop alive.

### HUMAN DECISION REQUIRED

Surface the material decision to the user using the escalation format.

After the user answers:

- if code changes are required, send the decision to a fresh fixer and then start a fresh review;
- if the answer only resolves review intent/risk without code changes, resume the reviewer as appropriate and obtain an updated verdict;
- for a materially changed interpretation of requirements, prefer another fresh review before declaring readiness.

## Worker lifecycle

Use Herdr's agent lifecycle instead of scraping prompt characters.

For each worker:

- give it a unique phase-oriented name;
- start it in the task worktree using the approved agent kind;
- submit one clear phase contract;
- wait for lifecycle settlement (`blocked` or completion/idle according to the installed Herdr version);
- read enough recent output to understand result/blocking state;
- keep user focus on the coordinator unless the user chooses to inspect a worker directly.

Run the installed Herdr command help rather than embedding assumptions about a particular release's flags.

A worker reaching idle is not sufficient proof of phase success: also check the expected artifact, Git state, validation result, or review verdict.

Do not reuse an implementation agent as the reviewer.
Do not reuse a fixer as the next reviewer.

## Failure and recovery

If a worker crashes or Herdr loses detection:

1. inspect the worktree and artifacts;
2. update `state.json` with the observed state;
3. restart the current phase in a fresh context when safe;
4. do not repeat completed destructive actions blindly;
5. surface the failure to the user only when autonomous recovery is unsafe or blocked.

If `/deliver <work-id>` is invoked again and state already exists, resume from the earliest phase that is not demonstrably complete.

Examples:

- `plan.md` exists but no implementation diff/validation → resume implementation;
- implementation exists but no reliable review verdict → start review;
- `review.md` says CHANGES REQUIRED → continue fix/re-review;
- `review.md` says PASS but the branch changed afterward → review again;
- state says PASS but evidence/artifacts disagree → trust current repository evidence, not stale state.

## Final readiness checks

Before notifying the user, verify:

- `request.md` exists;
- the handoff exists when the task required one;
- implementation is present on the task branch;
- relevant automated validation passed, or any accepted limitation is explicit;
- required runtime verification passed;
- frontend/UI functionality was independently exercised during review when applicable;
- `review.md` currently says `PASS`;
- the PASS applies to the current branch HEAD/diff, not an earlier version;
- there are no unresolved confirmed BLOCKER/IMPORTANT findings;
- there is no unresolved human decision;
- the task branch/worktree is intact for the user's inspection;
- nothing was merged, landed, deployed, or pushed unless explicitly authorized.

Then set `state.json` to:

```text
phase: ready_for_human_review
status: ready
```

and notify the user concisely with:

- work ID and branch;
- what was implemented;
- validation/runtime verification performed;
- review outcome and number/nature of fix cycles when useful;
- any non-blocking limitations worth knowing;
- confirmation that the branch is ready for **their final review**.

Do not describe the task as merged or complete beyond that boundary.

## Completion standard

`/deliver` is complete when the branch has survived implementation verification and the independent `/review` process reports PASS for the current code, with all material human decisions resolved, and the user has been notified that it is ready for final review.
