#!/bin/sh
set -eu

chflags nohidden "$HOME/Library"
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
