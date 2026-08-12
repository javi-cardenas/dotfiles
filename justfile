default:
    @just --list

brew:
    @./scripts/brew.sh

macos:
    @./scripts/macos.sh

stow:
    cd stow && stow --target "$HOME" *
    ls -la "$HOME/.config"

unstow:
    cd stow && stow --target "$HOME" --delete *

update:
    just brew
    just macos
    just unstow
    just stow
