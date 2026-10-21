#!/usr/bin/env bash
set -uo pipefail

script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")

# exits 1 when anything is installed that the Brewfile doesn't list
output=$(brew bundle cleanup --file="$repo_dir/Brewfile" </dev/null 2>/dev/null)
status=$?

if [ "$status" -eq 0 ]; then
  echo "No drift detected..."
  exit 0
fi

echo "[WARNING] Drift detected..."
awk '
  /^Would untap/ { keep = 1; print "Taps:"; next }
  /^Would uninstall / { keep = 1; sub(/^Would uninstall /, ""); print toupper(substr($0, 1, 1)) substr($0, 2); next }
  /^(Would|Run) / { keep = 0 }
  keep { print "  " $0 }
' <<<"$output"
echo "Add the above tools to the Brewfile or remove them with: just prune"
exit 1
