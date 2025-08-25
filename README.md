# Mac Setup

This doc has been updated to work for macOS 15 Sequoia. This [repo](https://github.com/javi-cardenas/.dotfiles) contains a shell script, a Brewfile, and other config files. Run the shell script to automate the steps below.

## Getting Started

- [Xcode CLI Tools](#xcode-cli-tools)
- [Homebrew](#homebrew)

## Xcode CLI Tools

Install Xcode CLI Tools...

```sh
xcode-select --install
```

## Homebrew

Install [Homebrew](https://brew.sh/)...

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
