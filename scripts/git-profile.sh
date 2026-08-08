#!/usr/bin/env bash
set -euo pipefail

PERSONAL_EMAIL="85462046+javi-cardenas@users.noreply.github.com"
PERSONAL_GITHUB_USER="javi-cardenas"

printf "Use personal git config? [Y/n]: "
read -r choice

case "$choice" in
    n|N|no|No)
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
        ;;
    *)
        git config --global user.email "$PERSONAL_EMAIL"
        git config --global github.user "$PERSONAL_GITHUB_USER"
        ;;
esac
