#!/usr/bin/env bash
set -uo pipefail

# undoes what `just up`, `just launchd`, `just macos` put on the Machine
#   always   Stow links in $HOME, skill links in ~/.claude/skills, launchd agents and their log
#   --macos  resets the defaults that scripts/macos.sh writes (keep the two in sync)
#   --brew   uninstalls every Formula, Cask and tap in the Brewfile
# prints the plan first and only changes anything after a confirmation, --dry-run stops there
# never touches the repo itself, ~/.claude and ~/.config/zed state, Homebrew, or the firewall

usage() {
  cat <<EOF
Usage: $0 [options]

  --dry-run      print the plan and change nothing
  --yes          don't ask for confirmation
  --keep-copies  replace each Stow link with a real copy of the file, so the Machine keeps its config
  --macos        also reset the macOS defaults set by scripts/macos.sh
  --brew         also uninstall everything in the Brewfile (includes git, gh and t3-code)
  -h, --help     show this help
EOF
}

dry_run=0 assume_yes=0 keep_copies=0 do_macos=0 do_brew=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=1 ;;
    --yes) assume_yes=1 ;;
    --keep-copies) keep_copies=1 ;;
    --macos) do_macos=1 ;;
    --brew) do_brew=1 ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      exit 2
      ;;
  esac
done

script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$script_dir")
stow_dir="$repo_dir/stow"

apply=0   # 0 prints the plan, 1 makes the changes
changes=0 # counted during the plan
failed=0
macos_changed=0 # set during the plan, so the apply knows whether to restart apps

say() { printf '%s\n' "$*"; }

# do_it <description> <command...>
do_it() {
  local description=$1
  shift
  if [ "$apply" -eq 0 ]; then
    say "[PLAN] $description"
    changes=$((changes + 1))
  elif "$@"; then
    say "[DONE] $description"
  else
    say "[FAIL] $description"
    failed=1
  fi
}

# --- Stow links

# shellcheck disable=SC2329 # invoked via do_it
replace_with_copy() {
  local path=$1 source=$2
  cp -R "$source" "$path.dotfiles-tmp" && rm "$path" && mv "$path.dotfiles-tmp" "$path"
}

# true when <rel> sits inside one of the newline separated paths in <handled>
inside_handled() {
  local rel=$1 handled=$2 h
  while IFS= read -r h; do
    [ -n "$h" ] || continue
    case "$rel" in "$h"/*) return 0 ;; esac
  done <<<"$handled"
  return 1
}

# matches links by their stow/<package>/<path> ending instead of asking Stow, so it still works
# when the repo moved and the links dangle
unlink_stow_packages() {
  local pkg_dir pkg repo_path rel path link handled
  say ""
  say "== Stow links =="
  for pkg_dir in "$stow_dir"/*/; do
    pkg=$(basename "$pkg_dir")
    handled=""
    while IFS= read -r -d '' repo_path; do
      rel=${repo_path#"$stow_dir/$pkg/"}
      path="$HOME/$rel"
      inside_handled "$rel" "$handled" && continue

      if [ -L "$path" ]; then
        link=$(readlink "$path")
        case "$link" in
          */stow/"$pkg/$rel" | stow/"$pkg/$rel") ;;
          *)
            say "[SKIP] $path is a link to somewhere else ($link)"
            continue
            ;;
        esac
        handled="$handled
$rel"
        if [ "$keep_copies" -eq 1 ]; then
          do_it "replace link $path with a copy" replace_with_copy "$path" "$repo_path"
        else
          do_it "remove link $path" rm "$path"
        fi
      elif [ -e "$path" ] && [ -f "$repo_path" ]; then
        say "[SKIP] $path is a regular file, not a link, left alone"
      fi
    done < <(find "$stow_dir/$pkg" -mindepth 1 -print0)
  done
}

# --- skill links made by scripts/link-skills.sh

# shellcheck disable=SC2329 # invoked via do_it
remove_skill_links() {
  local skills_dir="$HOME/.claude/skills" link target
  for link in "$skills_dir"/*; do
    [ -L "$link" ] || continue
    target=$(readlink "$link")
    case "$target" in */.agents/skills/*) rm "$link" || return 1 ;; esac
  done
  rmdir "$skills_dir" 2>/dev/null || true # only goes away if nothing else is in it
}

unlink_skills() {
  local skills_dir="$HOME/.claude/skills" link target count=0
  say ""
  say "== Skill links =="
  [ -d "$skills_dir" ] || return 0
  if [ "$keep_copies" -eq 1 ]; then
    say "[SKIP] keeping $skills_dir, its links point at the copied ~/.agents/skills"
    return 0
  fi
  for link in "$skills_dir"/*; do
    [ -L "$link" ] || continue
    target=$(readlink "$link")
    case "$target" in */.agents/skills/*) count=$((count + 1)) ;; esac
  done
  [ "$count" -gt 0 ] && do_it "remove $count skill links in $skills_dir" remove_skill_links
  return 0
}

# --- launchd agents made by scripts/launchd.sh

# shellcheck disable=SC2329 # invoked via do_it
unload_agent() {
  local label=$1 plist=$2
  launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true # not loaded is fine
  rm -f "$plist"
}

remove_launchd_agents() {
  local plist label log_file="$HOME/Library/Logs/brew-update.log"
  say ""
  say "== launchd agents =="
  for plist in "$HOME"/Library/LaunchAgents/local.dotfiles.*.plist; do
    [ -e "$plist" ] || continue
    label=$(basename "$plist" .plist)
    do_it "unload and remove $label" unload_agent "$label" "$plist"
  done
  [ -f "$log_file" ] && do_it "remove $log_file" rm "$log_file"
  [ -d "${TMPDIR:-/tmp}/brew-update.lock" ] && do_it "remove stale lock ${TMPDIR:-/tmp}/brew-update.lock" rmdir "${TMPDIR:-/tmp}/brew-update.lock"
  return 0
}

# --- macOS defaults set by scripts/macos.sh

# reset_default <domain> <key> [host], deleting the key puts back macOS's own default
reset_default() {
  local domain=$1 key=$2 host=${3:-}
  if [ -n "$host" ]; then
    defaults -currentHost read "$domain" "$key" >/dev/null 2>&1 || return 0
    do_it "reset $domain $key (this Mac only)" defaults -currentHost delete "$domain" "$key"
  else
    defaults read "$domain" "$key" >/dev/null 2>&1 || return 0
    do_it "reset $domain $key" defaults delete "$domain" "$key"
  fi
}

# the keyboard shortcuts macOS.sh turns off are on by default
# shellcheck disable=SC2329 # invoked via do_it
restore_hotkey() {
  local id=$1 modifiers=$2
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$modifiers</integer></array><key>type</key><string>standard</string></dict></dict>"
}

hotkey_enabled() {
  [ "$(/usr/libexec/PlistBuddy -c "Print :AppleSymbolicHotKeys:$1:enabled" "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist" 2>/dev/null)" = true ]
}

# shellcheck disable=SC2329 # invoked via do_it
restart_macos_apps() {
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  killall Finder Dock ControlCenter 2>/dev/null || true
}

library_hidden() {
  case "$(ls -ldO "$HOME/Library")" in *hidden*) return 0 ;; esac
  return 1
}

reset_macos_defaults() {
  local before=$changes
  say ""
  say "== macOS defaults =="
  reset_default com.apple.finder AppleShowAllFiles
  reset_default com.apple.finder ShowPathbar
  reset_default com.apple.finder ShowStatusBar
  reset_default com.apple.finder FXRemoveOldTrashItems
  reset_default com.apple.dock minimize-to-application
  reset_default com.apple.dock autohide
  reset_default com.apple.dock show-recents
  reset_default NSGlobalDomain KeyRepeat
  reset_default NSGlobalDomain InitialKeyRepeat
  reset_default com.apple.AppleMultitouchTrackpad Clicking
  reset_default com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking
  reset_default NSGlobalDomain com.apple.mouse.tapBehavior host
  reset_default com.apple.menuextra.clock ShowSeconds
  reset_default com.apple.controlcenter BatteryShowPercentage host
  reset_default com.apple.screensaver idleTime host
  hotkey_enabled 64 || do_it "turn Spotlight search (cmd + space) back on" restore_hotkey 64 1048576
  hotkey_enabled 65 || do_it "turn the Finder search window (cmd + option + space) back on" restore_hotkey 65 1572864
  library_hidden || do_it "hide ~/Library in Finder again" chflags hidden "$HOME/Library"
  [ "$apply" -eq 0 ] && [ "$changes" -gt "$before" ] && macos_changed=1
  [ "$macos_changed" -eq 1 ] && do_it "restart Finder, Dock and Control Center" restart_macos_apps
  say "[NOTE] the firewall stays on"
  return 0
}

# --- Homebrew

uninstall_brewfile() {
  local brewfile="$repo_dir/Brewfile" item installed
  say ""
  say "== Homebrew =="
  if ! command -v brew >/dev/null; then
    say "[SKIP] brew isn't installed"
    return 0
  fi
  installed=$(brew list --cask -1)
  while IFS= read -r item; do
    grep -qx "$item" <<<"$installed" && do_it "uninstall Cask $item" brew uninstall --cask "$item"
  done < <(brew bundle list --cask --file="$brewfile")
  installed=$(brew list --formula -1)
  while IFS= read -r item; do
    grep -qx "$item" <<<"$installed" && do_it "uninstall Formula $item" brew uninstall --formula "$item"
  done < <(brew bundle list --formula --file="$brewfile")
  installed=$(brew tap)
  while IFS= read -r item; do
    grep -qx "$item" <<<"$installed" && do_it "untap $item" brew untap "$item"
  done < <(brew bundle list --tap --file="$brewfile")
  say "[NOTE] Formulae that another installed tool needs fail to uninstall, run brew autoremove afterwards"
  return 0
}

run_stages() {
  unlink_stow_packages
  unlink_skills
  remove_launchd_agents
  [ "$do_macos" -eq 1 ] && reset_macos_defaults
  [ "$do_brew" -eq 1 ] && uninstall_brewfile
  return 0
}

say "Uninstalling the dotfiles in $repo_dir"
if [ "$keep_copies" -eq 0 ]; then
  say "[NOTE] without --keep-copies, ~/.zshrc, ~/.gitconfig and the rest of the config are gone after this"
fi
run_stages

if [ "$changes" -eq 0 ]; then
  say ""
  say "Nothing to uninstall."
  exit 0
fi

say ""
if [ "$dry_run" -eq 1 ]; then
  say "Dry run, nothing changed."
  exit 0
fi

if [ "$assume_yes" -eq 0 ]; then
  read -r -p "Apply these $changes changes? [y/N] " reply || reply=""
  case "$reply" in
    y | Y | yes) ;;
    *)
      say "Aborted, nothing changed."
      exit 1
      ;;
  esac
fi

apply=1
run_stages

say ""
say "Left alone, remove by hand if you want them gone:"
say "  the repo:       rm -rf \"$repo_dir\""
say "  Homebrew:       https://github.com/Homebrew/install#uninstall-homebrew"
say "  ~/.zprofile:    written by the Homebrew installer, not by this repo"
exit "$failed"
