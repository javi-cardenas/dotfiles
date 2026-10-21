#!/usr/bin/env bash
set -euo pipefail

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on # turn on the firewall

chflags nohidden "$HOME/Library" # show ~/Library in Finder
defaults write com.apple.finder AppleShowAllFiles YES # show hidden files
defaults write com.apple.finder ShowPathbar -bool true # show the path bar
defaults write com.apple.finder ShowStatusBar -bool true # show the status bar
defaults write com.apple.finder FXRemoveOldTrashItems -bool true # empty trash after 30 days

defaults write com.apple.dock minimize-to-application -bool true # minimize windows into their app icon
defaults write com.apple.dock autohide -bool true # auto-hide the Dock
defaults write com.apple.dock show-recents -bool false # hide recent apps

defaults write NSGlobalDomain KeyRepeat -int 2 # fast key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15 # short delay before repeat starts

# tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true # built-in trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # Bluetooth trackpad
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 # this Mac's per-host copy

defaults write com.apple.menuextra.clock ShowSeconds -bool true # show seconds in the menu bar clock
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true # show battery percentage

defaults -currentHost write com.apple.screensaver idleTime -int 60 # start the screen saver after 60 seconds idle

# free cmd + space for Raycast: turn off Spotlight search (64) and Finder search window (65)
disable_hotkey() {
  local id=$1 modifiers=$2
  # 32 and 49 are the space key's character and key codes
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$modifiers</integer></array><key>type</key><string>standard</string></dict></dict>"
}
disable_hotkey 64 1048576 # cmd + space
disable_hotkey 65 1572864 # cmd + option + space
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u # apply hotkey changes without logging out

# restart apps so they pick up the new settings
killall Finder
killall Dock
killall ControlCenter
