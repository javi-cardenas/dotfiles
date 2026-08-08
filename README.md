# macOS Setup
My dotfiles and setup instructions for macOS 26.

## Prerequisites
### Homebrew
Install [Homebrew](https://brew.sh/).

#### Brewfile
A [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile) is a single configuration file that lists all my Homebrew packages, letting me set up new machines with one command.

`brew` installs CLI tools to `/opt/homebrew` and `cask` installs GUI applications to `/Applications`.

## Setup
Download my code as a ZIP.

```sh
just brew <personal> # install base and/or personal packages
```

## GitHub
Create an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and add it to my [GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account), then clone the repo.

```sh
ssh-keygen -t ed25519 -C "85462046+javi-cardenas@users.noreply.github.com" # create ssh key
pbcopy < ~/.ssh/id_ed25519.pub # copy ssh key to clipboard
ssh -T git@github.com # verify ssh connection
git clone git@github.com:javi-cardenas/dotfiles.git # clone repo
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
[Raycast](https://raycast.com/) is my Spotlight replacement; remap `cmd + space` and create hotkeys for window management.

- Settings > Keyboard > Keyboard Shortcuts > Spotlight > Show Spotlight search > Off
- Raycast > Settings > Extensions > Window Management

### Security
- Network > Firewall > On
- General > Sharing > Local hostname > Edit
- Notifications > Allow notifications when the screen is locked > Off
- Privacy & Security > FileVault > Turn On

### Battery
- Charging > Charge Limit > 80%

### Storage
- General > Storage > Empty Trash automatically

### Desktop & Dock
- Minimize windows into application icon > On
- Automatically hide and show the Dock > On
- Show suggested and recent apps in Dock > Off

### Menu Bar
- Clock > Display the time with seconds
- Battery > Show percentage

#### Screen Saver
- Wallpaper > Screen Saver > Start Screen Saver > After 1 minute

### Keyboard
- Key repeat rate > Fast
- Delay until repeat > Short
- Turn keyboard backlight off after inactiviy > After 5 seconds

### Trackpad
- Tap to click > On
