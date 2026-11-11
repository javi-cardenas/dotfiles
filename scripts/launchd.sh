#!/usr/bin/env bash
set -euo pipefail

# installs the launchd agents that run brew-update.sh
# unlike cron, launchd runs a job at the next wake if the Mac was asleep at the scheduled time
# (missed runs of the same job are merged into one, a Mac that was powered off still skips it)

script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd)
agents_dir="$HOME/Library/LaunchAgents"
mkdir -p "$agents_dir"

# install <mode> <schedule keys as plist xml>
install() {
  local mode=$1 schedule=$2
  local label="local.dotfiles.brew-$mode"
  local plist="$agents_dir/$label.plist"

  cat >"$plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$label</string>
  <key>ProgramArguments</key>
  <array>
    <string>$script_dir/brew-update.sh</string>
    <string>$mode</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
$schedule
  </dict>
  <key>ProcessType</key>
  <string>Background</string>
</dict>
</plist>
EOF

  plutil -lint "$plist" >/dev/null
  launchctl bootout "gui/$UID/$label" 2>/dev/null || true # reload if it's already loaded
  launchctl bootstrap "gui/$UID" "$plist"
  echo "Loaded $label"
}

# every day at 12:00
install vulnerable '    <key>Hour</key><integer>12</integer>
    <key>Minute</key><integer>0</integer>'

# every Thursday at 8:00, Weekday 4 is Thursday
install weekly '    <key>Weekday</key><integer>4</integer>
    <key>Hour</key><integer>8</integer>
    <key>Minute</key><integer>0</integer>'
