## MacOS Setup with Dotfiles

This doc has been updated to work for macOS 15 Sequoia. This [repo](https://github.com/javi-cardenas/.dotfiles) contains a shell script, a Brewfile, and other config files. Run the following command to automate most steps below.

```sh
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/javi-cardenas/dotfiles/main/install.sh)"
```

## Dev Setup

- [Homebrew](#homebrew)
- Proton Suite
- [Raycast]
- Cursor
- Ghostty

## Homebrew

Install [Homebrew](https://brew.sh/)

Note: After installing, follow the instructions in your terminal to add Homebrew to your PATH..

For later, use `brew update` to make sure everything is up-to-date

## VPN and Password Manager

Used for privacy and getting my GitHub credentials..

```sh
brew install --cask \
protonvpn \
proton-pass
```

## [GitHub SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```sh
ssh-keygen -t ed25519 -C "85462046+javi-cardenas@users.noreply.github.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

Add the SSH key to your [GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) and clone the repo below..

```sh
git clone git@github.com:javi-cardenas/dotfiles.git
```

## Brewfile

Install Brewfile dependencies..

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

## Configure Raycast
Remove Spotlight search keyboard shortcut and make Command + Space the Raycast keyboard shortcut

System Settings > Keyboard > Keyboard Shortcuts > Spotlight > Uncheck "Show Spotlight search"

## Configure Git

```sh
touch ~/.gitconfig
nano ~/.gitconfig
```
Copy and paste the .gitconfig contents here..

### Node Version Manager (nvm)
https://github.com/nvm-sh/nvm/blob/master/README.md#installing-and-updating

```sh
nvm install --lts
```

## Mac Settings
### Security
- Filevault: Privacy & Security > Filevault > Turn On (encrypts SSD)
- Firewall: Network > Firewall > On
- Search "Sharing"
    - remove name from local hostname: Sharing > Local hostname > Edit
    - make sure all file sharing is disabled
- Notifications > Allow notifications when the screen is locked > Off

## Dock
- Dock > Minimize windows into application icon > On
- Dock > Automatically hide and show the Dock > On
- Mission Control > Group windows by application > On

## Control Center
Other Modules > Battery > Show Percentage > On
Menu Bar Only > Clock Options > Display the time with seconds > On
Menu Bar Only > Spotlight > Don't Show in Menu Bar

## Military Time
General > Date & Time > 24-hour time & Lock Screen > On

## Keyboard
Key repeat rate > Fast
Delay Uuntil repeat > Short

## Trackpad
Tap to click

## Finder

Show the Library folder, hidden files, the path bar, and the status bar

```sh
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
```

To get the Home folder in the finder, press CMD + SHIFT + H and drag the home folder to the sidebar.

## Extra
Turn on trash after 30 days

## Widgets
- Remove all widgets

### ohmyzsh
https://github.com/ohmyzsh/ohmyzsh/

