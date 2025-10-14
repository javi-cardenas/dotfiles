## MacOS Setup with Dotfiles

This doc has been updated to work for macOS 15 Sequoia. This [repo](https://github.com/javi-cardenas/.dotfiles) contains a shell script, a Brewfile, and other config files. Run the following command to automate most steps below.

```sh
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/javi-cardenas/dotfiles/main/install.sh)"
```

## Getting Started

- [Homebrew](#homebrew)
- Proton Suite
- [Raycast]
- Cursor
- Ghostty

## Homebrew

Install [Homebrew](https://brew.sh/)

Note: After installing, follow the instructions in your terminal to add Homebrew to your PATH...

For later, use `brew update` to make sure everything is up-to-date.

## Setup Git
```sh
touch ~/.gitconfig
nano ~/.gitconfig
```

### [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```sh
ssh-keygen -t ed25519 -C "85462046+javi-cardenas@users.noreply.github.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

### Brewfile

Install Brewfile dependencies...

```sh
brew bundle install
```

For later...

```sh
brew bundle upgrade
```

```sh
brew bundle dump # dump all dependencies into a Brewfile
```

## Proton Suite
- ProtonVPN
- Proton Pass
- Proton Mail
- Proton Drive

## Raycast
Disable Apple's Spotlight and replace that hotkey with Raycast

## Ghostyy


## Git
git config file

### GitHub SSH
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-yo$

## Cursor

### ohmyzsh
https://github.com/ohmyzsh/ohmyzsh/

### Node Version Manager (nvm)
https://github.com/nvm-sh/nvm/blob/master/README.md#installing-and-updating

```sh
nvm install --lts
```

# Mac Settings
## Security
Turn FileVault On (makes sure SSD is securely encrypted)
Network > Firewall > On
Sharing
Change computer name
Make sure all file sharing is disabled
Notifications when the screen is locked > Off


## Dock
Automatically hide and show Dock
Minimize windows into application icon
Group windows by application

## Widgets

## Control Center
Display the time in seconds
Battery
Focus mode

## Keyboard
Keyboard brightness
Key Repeat -> Fast
Delay Until Repeat -> Short

## Trackpad
Tap to click

## Battery


## Finder
# Show Library folder
chflags nohidden ~/Library

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

To get the Home folder in the finder, press CMD + SHIFT + H and drag the home folder to the sidebar.

## Extra
Turn on trash after 30 days