#!/usr/bin/env bash
set -euo pipefail

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

chflags nohidden "$HOME/Library"
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

killall Finder
killall Dock
