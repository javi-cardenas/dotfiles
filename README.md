# macOS Setup
My dotfiles and setup instructions for macOS 26.

## Prerequisites
### Homebrew
Install [Homebrew](https://brew.sh/).

#### Brewfile
A [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile) is a single configuration file that lists all my Homebrew packages, letting me set up new machines with one command.

## Setup
Download my code as a ZIP.

```sh
just brew work     # install shared and work packages
just brew personal # install shared and personal packages
```

`brew` installs CLI tools to `/opt/homebrew` and `cask` installs GUI applications to `/Applications`

## GitHub
Create an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and add it to my [GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account), then clone the repo.

```sh
# create ssh key
ssh-keygen -t ed25519 -C "85462046+javi-cardenas@users.noreply.github.com"

# copy ssh key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub

# verify ssh connection
ssh -T git@github.com

# clone repo
git clone git@github.com:javi-cardenas/dotfiles.git
```

## Stow
[GNU Stow](https://www.gnu.org/software/stow/) creates symlinks from dotfiles in this repo to dotfiles in my home directory.

```sh
just stow # create symlinks
just unstow # remove symlinks
```

## macOS
### Finder

```sh
just finder # set finder preferences
```

### Raycast
[Raycast](https://raycast.com/) is my Spotlight replacement.

Turn the Spotlight hotkey off, remap `cmd + space` to Raycast, and create hotkeys for window management.

- Settings > Keyboard > Keyboard Shortcuts > Spotlight > Show Spotlight search > Off
- Raycast > Settings > Extensions > Window Management

### Security
- Network > Firewall > On
- General > Sharing > Local hostname > Edit
- Notifications > Allow notifications when the screen is locked > Off
- Privacy & Security > FileVault > Turn On

### Storage
- General > Storage > Empty Trash automatically

### Desktop & Dock
- Minimize windows into application icon > On
- Automatically hide and show the Dock > On
- Show suggested and recent apps in Dock > Off

### Keyboard
- Key repeat rate > Fast
- Delay until repeat > Short
- Turn keyboard backlight off after inactiviy > After 5 seconds

### Trackpad
- Tap to click > On
