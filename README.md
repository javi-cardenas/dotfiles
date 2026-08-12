# Dotfiles
My dotfiles for macOS 26.

## Prerequisites
### Homebrew
Install [Homebrew](https://brew.sh/).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### GitHub
Create a [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) and add it to my [GitHub account](https://github.com/settings/keys).

```sh
 # create and copy ssh key to clipboard
ssh-keygen -t ed25519 -C "85462046+javi-cardenas@users.noreply.github.com"
pbcopy < ~/.ssh/id_ed25519.pub
```

## Setup
Clone the repo and run the setup script. Use `just update` when pulling changes.

```sh
git clone git@github.com:javi-cardenas/dotfiles.git
cd dotfiles
./scripts/setup.sh  # install packages and setup dotfiles
```

### macOS
Setup runs automated preferences via `just macos` but manual setup is still needed for:

#### Raycast
[Raycast](https://raycast.com/) is my Spotlight replacement; remap `cmd + space` and create hotkeys for window management.

- Settings > Keyboard > Keyboard Shortcuts > Spotlight > Show Spotlight search > Off
- Raycast > Settings > Extensions > Window Management

#### Security
- General > Sharing > Local hostname > Edit
- Notifications > Allow notifications when the screen is locked > Off
- Privacy & Security > FileVault > Turn On

#### Battery
- Charging > Charge Limit > 80%

#### Menu Bar
- Clock > Display the time with seconds
- Battery > Show percentage

#### Screen Saver
- Wallpaper > Screen Saver > Start Screen Saver > After 1 minute

#### Keyboard
- Key repeat rate > Fast
- Delay until repeat > Short
- Turn keyboard backlight off after inactivity > After 5 seconds

#### Trackpad
- Tap to click > On

## Tools
### Brewfile
A [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile) is a configuration file with all my Homebrew packages, `brew` installs CLI tools to `/opt/homebrew` and `cask` installs GUI applications to `/Applications`.

### Just
[Just](https://github.com/casey/just) is a task runner that simplifies running commands.

### Stow
[GNU Stow](https://www.gnu.org/software/stow/) creates symlinks from dotfiles in this repo to dotfiles in my home directory.
