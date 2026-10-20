default:
    @just --list

# install the Brewfile and symlink every Stow package (safe to rerun)
up:
    brew bundle --verbose --file=Brewfile
    mkdir -p "$HOME/.claude" # keep ~/.claude a real dir so Claude runtime state stays out of the repo
    cd stow && stow --restow --adopt --target "$HOME" *
    @./scripts/link-skills.sh
    @git diff --quiet -- stow || echo "stow/ has uncommitted changes, stow --adopt may have pulled files in from $HOME: review with git diff -- stow"
    @./scripts/drift.sh || true

# check the Machine matches the repo, changing nothing
doctor:
    @./scripts/doctor.sh

# uninstall Formulae, Casks and taps not in the Brewfile
prune:
    brew bundle cleanup --force --file=Brewfile

# apply macOS defaults (needs sudo)
macos:
    @./scripts/macos.sh
