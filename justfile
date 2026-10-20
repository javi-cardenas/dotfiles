default:
    @just --list

# install the Brewfile and symlink every Stow package (safe to rerun)
up:
    brew bundle --verbose --file=Brewfile
    cd stow && stow --restow --adopt --target "$HOME" *
    @git diff --quiet -- stow || echo "stow/ has uncommitted changes, stow --adopt may have pulled files in from $HOME: review with git diff -- stow"

# apply macOS defaults (needs sudo)
macos:
    @./scripts/macos.sh
