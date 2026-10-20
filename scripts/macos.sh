#!/usr/bin/env bash
set -euo pipefail

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

chflags nohidden "$HOME/Library"
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool true # empty trash after 30 days

defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

defaults write NSGlobalDomain KeyRepeat -int 2 # fast
defaults write NSGlobalDomain InitialKeyRepeat -int 15 # short delay

# tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

defaults -currentHost write com.apple.screensaver idleTime -int 60 # seconds

# free cmd + space for Raycast: turn off Spotlight search (64) and Finder search window (65)
disable_hotkey() {
  local id=$1 modifiers=$2
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$modifiers</integer></array><key>type</key><string>standard</string></dict></dict>"
}
disable_hotkey 64 1048576 # cmd + space
disable_hotkey 65 1572864 # cmd + option + space
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

killall Finder
killall Dock
killall ControlCenter
