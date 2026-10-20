# Issue tracker: Linear

Issues and specs for this repo live in Linear, team `JAVI`, project "Autonomous Agents". Use the `linear-server` MCP for all operations.

## Conventions

- **Create an issue**: `save_issue` with team `JAVI` and project "Autonomous Agents".
- **Read an issue**: `get_issue` by identifier (e.g. `JAVI-12`), plus `list_comments` for the discussion.
- **List issues**: `list_issues` filtered to team `JAVI` and project "Autonomous Agents", with state or label filters as needed.
- **Comment on an issue**: `save_comment`.
- **Apply / remove labels**: `save_issue` with the updated label list.
- **Close**: set the state to `Done` (or `Canceled`) with `save_issue`, and comment with the reason.
- **Sub-issues and blocking**: use Linear's parent-issue and blocking relations via `save_issue`. Where a relation isn't available, add `Blocked by: JAVI-<n>` at the top of the issue body.

Workflow states: Backlog, Todo, In Progress, In Review, Done, Canceled, Duplicate.

## When a skill says "publish to the issue tracker"

Create a Linear issue in team `JAVI`, project "Autonomous Agents".

## When a skill says "fetch the relevant ticket"

Read it as in **Read an issue** above. The user will usually pass an identifier like `JAVI-12`.
