#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")

cd "$repo_dir"
brew bundle --verbose --file="Brewfile"

printf "Include personal packages? [Y/n]: "
read -r personal_choice

case "$personal_choice" in
    y|Y|yes|Yes)
        brew bundle --verbose --file="Brewfile.personal"
        ;;
esac

"$script_dir/git-profile.sh"
