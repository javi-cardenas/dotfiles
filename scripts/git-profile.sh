#!/usr/bin/env bash
set -euo pipefail

PERSONAL_EMAIL="85462046+javi-cardenas@users.noreply.github.com"
PERSONAL_GITHUB_USER="javi-cardenas"

profile=${1:-}

case "$profile" in
    work|personal) ;;
    *)
        echo "Error: profile must be 'work' or 'personal'..." >&2
        exit 2
        ;;
esac

if [ "$profile" = "personal" ]; then
    git config --global user.email "$PERSONAL_EMAIL"
    git config --global github.user "$PERSONAL_GITHUB_USER"
    exit 0
fi

current_email=$(git config --global user.email 2>/dev/null || true)
current_github_user=$(git config --global github.user 2>/dev/null || true)

if [ "$current_email" = "$PERSONAL_EMAIL" ] || [ "$current_github_user" = "$PERSONAL_GITHUB_USER" ]; then
    printf "Work email: "
    read -r work_email
    printf "Work GitHub username: "
    read -r work_github_user

    if [ -z "$work_email" ] || [ -z "$work_github_user" ]; then
        echo "Error: work email and GitHub username are required..." >&2
        exit 1
    fi

    git config --global user.email "$work_email"
    git config --global github.user "$work_github_user"
fi
