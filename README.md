# MacOS Setup with Dotfiles
This document has been updated to work for macOS 15 Sequoia. This repo contains a Brewfile and other configuration files. Download this repo as a zip to get started on a  new device.

## Dev Setup

- [Homebrew](#homebrew)
- [Proton Suite](#proton-suite)
- [Raycast](#raycast)
- [Brave](#brave-browser)
- [Oh My Zsh](#oh-my-zsh)
- [Stow](#stow)
- [Mise](#mise)
- [Rust](#rust)
- [Ghostty](#ghostty)
- [TMUX](#tmux)
- [Neovim](#neovim)
- [Cursor](#cursor)
- [MacOS](#macos)

## Homebrew

Install [Homebrew](https://brew.sh/).

**Note:** Make sure to follow the instructions in your terminal to add Homebrew to your PATH.

Run the following command to install all Brewfile dependencies.

```sh
brew bundle -v
```

## Proton Suite
Log into Proton VPN, Proton Pass, Proton Mail, and Proton Drive.

## Raycast
Make sure to turn off the Spotlight hotkey so it does not conflict with Raycast.

Create hotkeys for Window Management.

## Brave Browser
Customize Brave Browser.

## GitHub SSH
Create a [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) for GitHub.

```sh
ssh-keygen -t ed25519 -C "85462046+javi-cardenas@users.noreply.github.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

Add the SSH key to your [GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) and clone the repo below.

```sh
git clone git@github.com:javi-cardenas/dotfiles.git
```

## Oh My Zsh
Install [Oh My Zsh](https://ohmyz.sh/#install).

You can add shortcuts to your shell by going to ~/.zshrc and using the `alias` keyword.

## Stow

Creates symlinks from the home directory to this repo.

```sh
cd ~/repos/dotfiles/stow
stow -t ~ * # you can also provide a single directory
```

Verify symlinks were created.
```
ls ~/.config/
```

For future reference.
```
stow -t ~ --adopt nvim # use if you have existing config files

stow -t ~ -R nvim # updates symlinks, use after pulling changes

stow -t ~ -D nvim # removes symlinks
```

## Mise
TODO

```sh
mise i bun@latest
source ~/.zshrc
```

## Rust
Install [Rust](https://rust-lang.org/learn/get-started/) using Rustup.

## Ghostty
TODO

## TMUX
TODO

## Neovim
TODO

## Cursor
TODO

## MacOS

### Security
Filevault: Privacy & Security > Filevault > Turn On (Encrypts SSD)

Firewall: Network > Firewall > On

Rename local hostname: General > Sharing > Local hostname > Edit. Make sure all file sharing is also disabled.

Locked screen: Notifications > Allow notifications when the screen is locked > Off

### Storage

General > Storage > Empty Trash automatically

### Keyboard
Key repeat rate > Fast

Delay until repeat > Short

### Finder

Show the Library folder, hidden files, the path bar, and the status bar.

```sh
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
```

`cmd + shift + h` takes you to the to the Home folder in finder. Drag the home folder to the sidebar.