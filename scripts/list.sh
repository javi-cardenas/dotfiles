#!/bin/sh
set -eu

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")

just --justfile "$repo_dir/justfile" --list
