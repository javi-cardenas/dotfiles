#!/usr/bin/env bash
set -uo pipefail

# unattended Homebrew updates, run by launchd (see scripts/launchd.sh)
#   vulnerable  daily, upgrades only Formulae with open vulnerabilities
#   weekly      Thursday, installs what's missing from the Brewfile and upgrades all Formulae
# Casks are never upgraded here: they can need sudo or replace apps that are open, so they're just listed

mode=${1:-}
case "$mode" in
  vulnerable | weekly) ;;
  *)
    echo "Usage: $0 vulnerable|weekly" >&2
    exit 2
    ;;
esac

# launchd starts with a bare PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export HOMEBREW_NO_ENV_HINTS=1
export NONINTERACTIVE=1

script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")
log_file="$HOME/Library/Logs/brew-update.log"
mkdir -p "$(dirname "$log_file")"
exec >>"$log_file" 2>&1

# launchd can fire the daily and weekly jobs together after a wake, so run one at a time
lock_dir="${TMPDIR:-/tmp}/brew-update.lock"
for _ in $(seq 1 120); do
  mkdir "$lock_dir" 2>/dev/null && break
  sleep 30
done
if [ ! -d "$lock_dir" ] || ! trap 'rmdir "$lock_dir"' EXIT; then
  echo "[FAIL] could not get the lock"
  exit 1
fi

echo "=== $(date '+%Y-%m-%d %H:%M:%S') brew update ($mode) ==="

failed=0

step() {
  echo "--- $*"
  "$@" </dev/null || {
    echo "[FAIL] $*"
    failed=1
  }
}

step brew update
export HOMEBREW_NO_AUTO_UPDATE=1 # already updated above

if [ "$mode" = vulnerable ]; then
  step brew upgrade --vulnerable
else
  step brew bundle install --no-upgrade --file="$repo_dir/Brewfile" # installs anything missing from the Brewfile
  step brew upgrade --formula
  step brew cleanup
fi

echo "--- outdated Casks, upgrade by hand with: brew upgrade --cask"
brew outdated --cask --greedy </dev/null || true

echo "=== done, failed=$failed ==="
exit "$failed"
