# macOS Setup
My dotfiles and setup instructions for macOS 26.

## Prerequisites
### Homebrew
Install [Homebrew](https://brew.sh/).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Brewfile
A [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile) is a single configuration file that lists all my Homebrew packages, letting me set up new machines with one command. `brew` installs CLI tools to `/opt/homebrew` and `cask` installs GUI applications to `/Applications`.

## Setup
Download my code as a ZIP.

```sh
./scripts/setup.sh  # one time run to install packages and setup dotfiles
```

After just is installed, you can use `just update` to update packages and dotfiles.

## GitHub
Create an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and add it to my [GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account), then clone the repo.

```sh
 # create and copy ssh key to clipboard
ssh-keygen -t ed25519 -C  "$(git config --global user.email)" && pbcopy < ~/.ssh/id_ed25519.pub
```

```sh
git clone git@github.com:javi-cardenas/dotfiles.git
```

## Stow
[GNU Stow](https://www.gnu.org/software/stow/) creates symlinks from dotfiles in this repo to dotfiles in my home directory, `just stow` creates the symlinks and `just unstow` removes them.

## macOS
`just macos` applies system preferences, manual setup still required for the following:

### Raycast
[Raycast](https://raycast.com/) is my Spotlight replacement; remap `cmd + space` and create hotkeys for window management.

- Settings > Keyboard > Keyboard Shortcuts > Spotlight > Show Spotlight search > Off
- Raycast > Settings > Extensions > Window Management

### Security
- General > Sharing > Local hostname > Edit
- Notifications > Allow notifications when the screen is locked > Off
- Privacy & Security > FileVault > Turn On

### Battery
- Charging > Charge Limit > 80%

### Menu Bar
- Clock > Display the time with seconds
- Battery > Show percentage

### Screen Saver
- Wallpaper > Screen Saver > Start Screen Saver > After 1 minute

### Keyboard
- Key repeat rate > Fast
- Delay until repeat > Short
- Turn keyboard backlight off after inactiviy > After 5 seconds

### Trackpad
- Tap to click > On
