#!/usr/bin/env bash
set -uo pipefail

script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")
cd "$repo_dir" || exit

failed=0

check() {
  local name=$1
  shift
  local output
  if output=$("$@" 2>&1); then
    echo "[PASS] $name"
  else
    echo "[FAIL] $name"
    while IFS= read -r line; do
      echo "       $line"
    done <<<"$output"
    failed=1
  fi
}

packages=(stow/*)

# fails on conflicts, and on links stow would still have to create
# shellcheck disable=SC2329 # invoked via check
stow_linked() {
  local output
  output=$(stow --dir=stow --target="$HOME" --simulate --verbose "${packages[@]#stow/}" 2>&1) || {
    echo "$output"
    return 1
  }
  if grep '^LINK:' <<<"$output"; then
    echo "Missing links, run just up"
    return 1
  fi
}

check "Scripts shellcheck..." shellcheck scripts/*.sh stow/bin/bin/*
check "Brewfile installed..." brew bundle check --file=Brewfile
check "Stow packages linked..." stow_linked
check "No Brewfile drift..." ./scripts/drift.sh

exit "$failed"
