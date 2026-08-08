default:
    @just --list

brew:
    @./scripts/brew.sh

finder:
    chflags nohidden "$HOME/Library"
    defaults write com.apple.finder AppleShowAllFiles YES
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true

stow:
    cd stow && stow --target "$HOME" *
    ls -la "$HOME/.config"

unstow:
    cd stow && stow --target "$HOME" --delete *

update:
    just brew
    just unstow
    just stow
    just finder
