## Agent skills

### Issue tracker

Linear, team `JAVI`, project "Dotfiles", accessed via the `linear-server` MCP. See `docs/agents/issue-tracker.md`.

### Triage labels

Default triage labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: one `GLOSSARY.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.

## Verifying changes

Run `just doctor` after any change. It checks shellcheck, the Brewfile, Stow links and Drift, and changes nothing. `just up`, `just macos` and `just prune` change the Machine, so ask before running them.
