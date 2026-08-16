#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")

cd "$repo_dir"
"$script_dir/brew.sh"
just macos
rm ~/.gitconfig
just stow
