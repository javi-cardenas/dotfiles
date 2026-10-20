default:
    @just --list

# install the Brewfile and symlink every Stow package (safe to rerun)
up:
    brew bundle --verbose --file=Brewfile
    mkdir -p "$HOME/.claude" # keep ~/.claude a real dir so Claude runtime state stays out of the repo
    cd stow && stow --restow --adopt --target "$HOME" *
    @./scripts/link-skills.sh
    @git diff --quiet -- stow || echo "stow/ has uncommitted changes, stow --adopt may have pulled files in from $HOME: review with git diff -- stow"

# apply macOS defaults (needs sudo)
macos:
    @./scripts/macos.sh
