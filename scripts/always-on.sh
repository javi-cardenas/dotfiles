#!/usr/bin/env bash
set -euo pipefail

# keep a desktop Mac (like a Mac mini) awake so it works as an always-on server
if pmset -g batt | grep -q InternalBattery; then
  echo "This Mac has a battery, so it isn't a desktop. Not changing sleep settings." >&2
  exit 1
fi

sudo pmset -a sleep 0 # never sleep the system
sudo pmset -a disksleep 0 # never spin down disks
sudo pmset -a displaysleep 0 # never sleep the display
sudo pmset -a powernap 0 # turn off Power Nap
sudo pmset -a womp 1 # wake for network access
sudo pmset -a autorestart 1 # start up after a power failure

pmset -g | grep -E '^ *(sleep|disksleep|displaysleep|powernap|womp|autorestart) '
