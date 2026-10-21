# list just recipes
default:
    @just --list

# mostly used by agents to run repo checks
check:
    @./scripts/check.sh

# apply macOS defaults
macos:
    @./scripts/macos.sh

# use this on a new Mac
new: up macos

# uninstall tools not in the Brewfile
prune:
    brew bundle cleanup --force --file=Brewfile

# short for update, use this after every pull to install the Brewfile and symlink the Stow packages
up:
    brew bundle --verbose --file=Brewfile
    mkdir -p "$HOME/.claude" # makes a ~/.claude directory so Claude Code state stays out of the repo
    mkdir -p "$HOME/.config/zed" # makes a ~/.config/zed directory so Zed state stays out of the repo
    cd stow && stow --restow --adopt --target "$HOME" *
    @./scripts/link-skills.sh
    @git diff --quiet -- stow || echo "[WARNING] stow/ has uncommitted changes, stow --adopt may have pulled files in from $HOME: review with git diff -- stow"
    @if output=$(./scripts/drift.sh); then echo "$output"; else echo "[WARNING] $output"; fi

# update agent skills
skills:
    bunx skills update --global --yes
    git status --short -- stow/agents
