#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)

"$script_dir/brew.sh" "$@"
"$script_dir/unstow.sh"
"$script_dir/stow.sh"
"$script_dir/git-profile.sh" "$1"
