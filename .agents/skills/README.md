# Workplace Agent Skills v4

A lean skill set for using capable coding agents in established repositories without over-scaffolding them.

The skills are not intended to teach frontier models how to write software. They exist to provide:

- reusable workflow commands;
- clean context boundaries between planning, implementation, and review;
- a consistent local artifact protocol;
- deliberate quality gates where the process matters more than raw model capability.

The manual core workflow is:

```text
/explore WORK-ID
    ↓
shared understanding
    ↓
/handoff WORK-ID
    ↓
.work/active/WORK-ID/plan.md
    ↓
fresh context
    ↓
/implement WORK-ID
    ↓
fresh context
    ↓
/review WORK-ID
```

Not every task needs every phase. Use the minimum workflow necessary.

For autonomous end-to-end delivery inside Herdr:

```text
/deliver WORK-ID <task>
    ↓
explore + human decisions when truly needed
    ↓
handoff
    ↓
fresh implementer
    ↓
fresh adversarial review
    ↓
fresh fix / re-review loops as needed
    ↓
branch ready for your final review
```

## Skills

### `deliver`
Herdr-based autonomous coordinator. Owns a task from exploration through handoff, fresh-context implementation, runtime verification, rigorous review/fix loops, and notification when the branch is ready for final human review. It coordinates workers but does not implement product code itself.

### `explore`
Understand the requested change with the user before coding. Inspect the repository, surface important unknowns, and keep material product/design decisions visible rather than silently making them.

### `handoff`
Distill the current shared understanding into `.work/active/<work-id>/plan.md` so a fresh implementation context can execute without the original conversation.

### `implement`
Implement a normal feature/change. Automatically consumes `plan.md` when present and treats settled decisions as authoritative unless repository evidence materially contradicts them.

### `bugfix`
Evidence-first debugging. Reproduce the problem, establish root cause, make the smallest justified fix, and rerun the original reproduction.

### `review`
The strongest quality gate in the framework. A fresh, adversarial review that tries to find real defects that should block merge. Findings must be concrete and verified. Review is not artificially capped: it may iterate through fixes and re-review as many times as needed to reach a reliable result.

### `architect`
Optional design-only mode for important API, package, ownership, state, data-model, or concurrency decisions. Stops before implementation.

### `create-verification`
Create a repository-specific verification skill that teaches agents how to boot, exercise, observe, and clean up the real application or service.

## Local work artifacts

Use an ignored local directory:

```text
.work/
└── active/
    └── WORK-ID/
        ├── request.md         # autonomous delivery input
        ├── plan.md
        ├── investigation.md   # optional
        ├── review.md          # when reviewed
        └── state.json         # autonomous delivery recovery state
```

`.work/` should normally be added to the repository's local Git exclude file rather than committed.

These are transient agent working-memory artifacts, not durable architecture documentation.

## Suggested usage

### Autonomous delivery with Herdr

```text
/deliver DATA-123 Add the requested behavior from this ticket
```

`deliver` creates/reuses one task worktree, interrupts only for material decisions, uses fresh agents across implementation/review boundaries, requires real frontend functional verification when applicable, and stops with the branch ready for your final review. It does not merge or deploy.


### Small obvious change

```text
/implement DATA-123
/review DATA-123
```

### Normal meaningful ticket

```text
/explore DATA-123
/handoff DATA-123
# start a fresh agent/context
/implement DATA-123
# start a fresh reviewer/context
/review DATA-123
```

### Bug

```text
/bugfix DATA-123
/review DATA-123
```

### Design-heavy work

```text
/explore DATA-123
/architect DATA-123
/handoff DATA-123
/implement DATA-123
/review DATA-123
```

## Herdr

Herdr is the runtime/cockpit for autonomous `/deliver` workflows. The individual engineering skills remain orchestration-agnostic; `deliver` uses Herdr to provide worktree isolation, fresh agent contexts, lifecycle waiting, and recovery.

Useful patterns can be invoked in plain language when needed:

- **Arena** — several agents solve the same problem independently; compare the results.
- **Swarm** — split independent investigations across agents and synthesize the findings.

These are orchestration patterns, not permanent skills in v4.

## Installation

Run:

```bash
./scripts/install-claude.sh
```

By default this installs into `~/.claude/skills/`.

To install somewhere else:

```bash
./scripts/install-claude.sh /path/to/skills
```

## Design principle

For every instruction, ask:

> Would a strong coding model probably do this correctly from a normal request?

If yes, it usually does not belong in a skill.

Keep instructions that define:

- a phase boundary;
- an artifact or context-transfer contract;
- a deliberate quality standard;
- evidence requirements;
- repository-specific procedures.
