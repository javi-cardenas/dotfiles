#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")
profile=${1:-}

print_usage() {
    printf '%s\n' \
        "" \
        "Available profiles:" \
        "  work" \
        "  personal" \
        "" \
        "Usage:" \
        "  just brew <work|personal>" \
        "  just update <work|personal>" >&2
}

if [ "$#" -gt 1 ]; then
    echo "Error: expected exactly one profile." >&2
    print_usage
    exit 2
fi

case "$profile" in
    work|personal) ;;
    "")
        echo "Error: a profile is required." >&2
        print_usage
        exit 2
        ;;
    *)
        echo "Error: profile must be 'work' or 'personal'." >&2
        print_usage
        exit 2
        ;;
esac

"$script_dir/git-profile.sh" "$profile"

cd "$repo_dir"
brew bundle --verbose --file="Brewfile"
brew bundle --verbose --file="Brewfile.$profile"
