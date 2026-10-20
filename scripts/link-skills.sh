#!/usr/bin/env bash
set -euo pipefail

skills_dir="$HOME/.claude/skills"
mkdir -p "$skills_dir"

for skill in "$HOME"/.agents/skills/*/; do
  skill=${skill%/}
  ln -sfn "$skill" "$skills_dir/${skill##*/}"
done

# remove links to skills that no longer exist, leaving Claude's synced/ alone
for link in "$skills_dir"/*; do
  if [ -L "$link" ] && [ ! -e "$link" ]; then
    rm "$link"
  fi
done
