#!/bin/bash

set -euo pipefail # fail on any errors or unset variables
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "🚀 Setting up your Mac..."

# 1) Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  echo "⚙️ Installing Xcode CLI Tools..."
  xcode-select --install || true
else
  echo "✅ Xcode CLI Tools already installed."
fi

# 2) Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$('/opt/homebrew/bin/brew' shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$('/usr/local/bin/brew' shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

brew analytics off || true

# 3) Install apps and CLIs from Brewfile
echo "🍺 Installing applications from Brewfile..."
brew bundle install --file "$SCRIPT_DIR/Brewfile" --no-lock

echo "✅ Setup complete!"
