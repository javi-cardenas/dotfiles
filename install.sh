#!/bin/bash

# Error handling

set -e # Exit on any error

echo "🚀 Setting up your Mac..."

# Installations

echo "⚙️ Installing Xcode CLI Tools..."
xcode-select --install

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
command -v brew || export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin"
command -v brew && eval "$(brew shellenv)"
brew analytics off

# echo "🍺 Installing applications..."
brew bundle install

# Configurations

# echo "⚙️  Configuring Raycast..."
# # Set Raycast hotkey to Cmd+Space
# defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49"
# # Disable Spotlight's Cmd+Space hotkey to avoid conflicts
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# # Apply Raycast changes by restarting
# echo "🔄 Restarting Raycast to apply changes..."
# killall Raycast 2>/dev/null || true
# sleep 1
# open -a Raycast

# echo "✅ Setup complete! All applications configured."

# echo "👻 Configuring Ghostty..."
# # Create Ghostty config directory if it doesn't exist
# mkdir -p "$HOME/.config/ghostty"

# # Copy your ghostyy config to the correct location
# if [[ -d "$(pwd)/ghostyy" ]]; then
#     echo "📁 Copying Ghostty configuration..."
#     cp -r "$(pwd)/ghostyy/"* "$HOME/.config/ghostty/"
#     echo "✅ Ghostty configuration copied successfully"
# else
#     echo "❌ ghostyy directory not found in $(pwd)"
# fi
