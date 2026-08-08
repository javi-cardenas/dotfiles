default:
    @just --list

brew:
    @./scripts/brew.sh

finder:
    chflags nohidden "$HOME/Library"
    defaults write com.apple.finder AppleShowAllFiles YES
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true

macos:
    just finder
    defaults write com.apple.dock minimize-to-application -bool true
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock show-recents -bool false
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
    killall Finder
    killall Dock

stow:
    cd stow && stow --target "$HOME" *
    ls -la "$HOME/.config"

unstow:
    cd stow && stow --target "$HOME" --delete *

update:
    just brew
    just unstow
    just stow
    just macos
