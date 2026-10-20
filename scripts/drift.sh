#!/usr/bin/env bash
set -uo pipefail

script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")

# exits 1 when anything is installed that the Brewfile doesn't list;
# stdin and stdout aren't a TTY here, so it never prompts to remove
output=$(brew bundle cleanup --file="$repo_dir/Brewfile" </dev/null 2>/dev/null)
status=$?

if [ "$status" -eq 0 ]; then
  echo "No Drift: everything installed is in the Brewfile"
  exit 0
fi

echo "Drift: installed but not in the Brewfile"
# keep the Formulae, Casks and taps; drop brew cleanup's cache listing
awk '/^Would (uninstall|untap)/ { keep = 1; print; next } /^(Would|Run) / { keep = 0 } keep { print "  " $0 }' <<<"$output"
echo "Add them to the Brewfile, or remove them with: just prune"
exit 1
