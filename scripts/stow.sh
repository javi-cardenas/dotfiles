#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")

cd "$repo_dir/stow"
stow --target "$HOME" *
ls -la "$HOME/.config"
