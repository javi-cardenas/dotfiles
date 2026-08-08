default:
    @just --list

brew profile="":
    #!/usr/bin/env bash
    set -euo pipefail
    ./scripts/brew.sh "{{profile}}"
    if [ -z "{{profile}}" ]; then
        ./scripts/git-profile.sh
    fi

finder:
    @./scripts/finder.sh

stow:
    @./scripts/stow.sh

unstow:
    @./scripts/unstow.sh

update profile="":
    @./scripts/update.sh "{{profile}}"

git-profile:
    @./scripts/git-profile.sh
