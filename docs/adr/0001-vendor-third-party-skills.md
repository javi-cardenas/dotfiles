# Vendor third-party skills

Third-party agent skills are committed in full under `stow/agents/.agents/skills/`, not restored from `.skill-lock.json` at setup time. These files steer every agent on the Machine, so upstream changes should arrive as a git diff to review before they take effect, and setup shouldn't need the network or the `skills` CLI to work. The cost is that most tracked files are third-party and skill updates make large diffs.

## Considered Options

- **Commit only `.skill-lock.json` and reinstall on setup**: smaller repo, but upstream changes apply silently and setup depends on the `skills` CLI supporting restore from the lock file.
