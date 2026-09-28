---
name: create-verification
description: Create a repository-specific verification skill that teaches future agents how to launch, exercise, observe, and clean up the real application or service. Use when runtime proof requires project-specific procedural knowledge.
---

# Create Verification Skill

Create a repository-local verification skill for the application/service being worked on.

The purpose is to capture **project-specific procedural knowledge the model cannot reliably infer every time**.

## Investigate the real workflow

Determine how to:

1. **Launch** — start the relevant application, dependencies, test environment, fixtures, or local stack.
2. **Doctor** — confirm prerequisites and readiness before testing behavior.
3. **Drive** — exercise the real user/API/CLI/runtime surface.
4. **Observe** — inspect the response, database, event, log, UI, filesystem, or other externally meaningful result.
5. **Clean up** — stop processes and remove temporary state safely.

Prefer the real runnable artifact over proxies such as only compiling or only running unit tests.

## Output location

Create an appropriately named repository skill, for example:

```text
.claude/skills/verify-service/SKILL.md
```

or:

```text
.claude/skills/verify-admin-ui/SKILL.md
```

Supporting scripts may live beside the skill when they make verification safer or repeatable.

## Skill contents

The generated verification skill should contain:

- prerequisites;
- exact or discoverable startup commands;
- readiness checks;
- authentication/setup steps when required;
- representative verification flows;
- the expected observable outcomes;
- useful diagnostics when a check fails;
- cleanup instructions;
- safety constraints around local/shared environments.

Avoid hard-coding secrets.
Avoid destructive operations against shared or production environments.

## Standard

The resulting skill should let a fresh agent prove that a behavior works without reconstructing the repository's runtime procedure from scratch.
