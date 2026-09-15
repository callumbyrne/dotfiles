# Workplace Agent Skills

A small, composable engineering workflow for team-owned repositories.

## Skills

- `explore` — investigate and discuss work without implementing it.
- `plan` — capture an agreed approach as a concise, disposable implementation handoff.
- `implement` — execute a clear ticket or approved plan without unnecessarily redesigning it.
- `wayfind` — resolve decision-focused unknowns before planning large or fuzzy work.
- `review` — perform a bounded adversarial review focused on concrete production-relevant defects.

## Local workspace

Temporary work artifacts live under a repo-local, normally gitignored `.work/` directory:

```text
.work/
├── active/
│   ├── DATA-421/
│   │   ├── plan.md
│   │   └── investigation.md     # optional
│   └── auth-migration/
│       ├── wayfind.md
│       ├── investigations/      # optional parallel/deep research outputs
│       └── plan.md              # appears when ready to implement
└── archive/
```

Use a ticket identifier as `<work-id>` when one exists. Otherwise use a short, stable kebab-case slug.

Recommended `.gitignore` entry:

```gitignore
.work/
```

The `.work/` directory is a local execution workspace, not durable project documentation.

- `plan.md` is the canonical handoff from planning to implementation.
- `investigation.md` is optional and only exists when exploration findings must survive a context boundary.
- `wayfind.md` is the decision map for large/uncertain work.
- `investigations/` contains optional detailed outputs from parallel scouts or deeper investigations.
- completed workspaces may be moved from `active/` to `archive/`, or deleted.

Durable architecture/domain knowledge belongs in the repository's normal docs or ADR process instead.

## Suggested flow

```text
incoming work
    |
    +-- clear + small --------------------> implement
    |
    +-- needs understanding --> explore
                                  |
                                  +-- clear + small --> implement
                                  |
                                  +-- agreed but handoff useful
                                  |       |
                                  |       +--> .work/active/<id>/plan.md
                                  |                    |
                                  |               fresh implementer
                                  |
                                  +-- still too undefined
                                          |
                                          +--> wayfind.md / investigations/
                                                     |
                                                     +--> plan.md
```

For multiple concurrent tasks, keep orchestration separate:

```text
you <-> coordinator/orchestrator
          |
          +-- worker A -> explore/plan/implement
          +-- worker B -> explore/plan/implement
          +-- worker C -> wayfind investigation
```

The skills define **how engineering work is performed**. A tool such as Firstmate/Herdr can define **who runs which skill, in which worktree, and when**.

## Artifact lifecycle

A typical planned task:

```text
/explore DATA-421
        |
        | conversation; no file by default
        v
/plan
        |
        v
.work/active/DATA-421/plan.md
        |
        | context boundary / fresh worker
        v
/implement DATA-421
        |
        v
implementation + validation + review
        |
        +--> archive .work/active/DATA-421
        |          to .work/archive/DATA-421
        |
        `--> or delete it
```

A typical wayfinding task:

```text
.work/active/<initiative>/wayfind.md
          |
          +--> investigations/a.md
          +--> investigations/b.md
          |
          v
      decisions resolved
          |
          v
        plan.md
          |
          v
      implementation
```

## Review lifecycle

After implementation and normal project validation:

```text
fresh adversarial reviewer
        |
        v
    findings
        |
        v
verify BLOCKER / IMPORTANT
        |
        +--> disproved -> discard
        +--> human decision -> escalate
        `--> confirmed -> fix worker
                          |
                          v
                    one delta review
                          |
                          v
                         stop
```

Review artifacts live at:

```text
.work/active/<work-id>/review.md
```

The reviewer must describe concrete failure scenarios rather than generic concerns. The default process is deliberately bounded to avoid open-ended "review until zero findings" loops.

## Principles

1. Use the minimum planning machinery necessary.
2. Keep product tickets as the source of truth for product intent.
3. Explore before planning when important context is missing.
4. Plans record agreed decisions; they should not restart discovery.
5. Plans are disposable execution artifacts unless they contain genuinely durable knowledge.
6. Fresh implementation contexts are useful when a plan is acting as a handoff contract.
7. Testing is expected where appropriate; TDD is not mandated.
8. Workers escalate material conflicts instead of silently redesigning the work.
9. Wayfinding produces decisions, not production implementation.
10. Review is adversarial but bounded: prove concrete failure scenarios, verify findings, and stop after one delta re-review.
11. Keep orchestration concerns out of the engineering skills themselves.

## Installation

Copy each skill directory into the skills location used by your coding agent:

```text
skills/
  explore/
    SKILL.md
  plan/
    SKILL.md
  implement/
    SKILL.md
  wayfind/
    SKILL.md
  review/
    SKILL.md
```

These files intentionally use only simple `name` and `description` frontmatter so they remain easy to adapt across agent environments.
