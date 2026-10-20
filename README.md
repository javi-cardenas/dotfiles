# Dotfiles
My dotfiles for macOS. The repo describes one Mac, and anything installed or configured outside it is Drift. See [GLOSSARY.md](GLOSSARY.md) for the terms.

## New Mac
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

### Setup
```sh
brew install just
git clone git@github.com:javi-cardenas/dotfiles.git
cd dotfiles
just up
just macos
```

Then work through the manual steps below.

## Commands
| Command | What it does |
| --- | --- |
| `just up` | Installs the Brewfile, symlinks every Stow package, links agent skills into Claude and reports Drift. Safe to rerun, so run it after every pull or Brewfile edit. |
| `just macos` | Applies macOS defaults and turns on the firewall. Needs sudo and restarts Finder, Dock and Control Center. |
| `just doctor` | Checks shellcheck, the Brewfile, Stow links and Drift without changing anything. |
| `just prune` | Uninstalls Formulae, Casks and taps the Brewfile doesn't list. |
| `just skills` | Updates Vendored skills. Review the diff before committing. |

If a real file already sits where a symlink goes, `just up` adopts it into `stow/` and warns you. Review it with `git diff -- stow`, then commit it or `git restore stow` to keep the repo version.

## Manual steps
These are the settings `just macos` can't set.

### Raycast
[Raycast](https://raycast.com/) replaces Spotlight. `just macos` frees up `cmd + space`.

- Raycast > Settings > General > Raycast Hotkey > `cmd + space`
- Raycast > Settings > Extensions > Window Management > set hotkeys
- Raycast > Settings > Advanced > Import / Export to move settings between Macs

### Security
- General > Sharing > Local hostname > Edit
- Notifications > Allow notifications when the screen is locked > Off
- Privacy & Security > FileVault > On

### Battery
- Charging > Charge Limit > 80%

### Keyboard
- Turn keyboard backlight off after inactivity > After 5 seconds
