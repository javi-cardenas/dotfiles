#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")
profile=${1:-}

print_usage() {
    printf '%s\n' \
        "" \
        "Available profiles:" \
        "  personal" \
        "" \
        "Usage:" \
        "  just brew" \
        "  just brew personal" \
        "  just update" \
        "  just update personal" >&2
}

if [ "$#" -gt 1 ]; then
    echo "Error: expected at most one profile." >&2
    print_usage
    exit 2
fi

case "$profile" in
    ""|personal) ;;
    *)
        echo "Error: profile must be 'personal'." >&2
        print_usage
        exit 2
        ;;
esac

cd "$repo_dir"
brew bundle --verbose --file="Brewfile"

if [ "$profile" = "personal" ]; then
    brew bundle --verbose --file="Brewfile.personal"
fi
