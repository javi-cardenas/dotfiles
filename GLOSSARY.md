# Dotfiles

The declarative description of what's installed, how it's configured, and what still has to be done by hand.

## Language

### What the repo describes

**Machine**:
The single personal Mac this repo describes.
_Avoid_: host, computer, profile

**Stow package**:
A directory under `stow/` that mirrors part of the home directory and is symlinked into it as a unit.
_Avoid_: package (bare), module, dotfile group

**Formula**:
A command-line tool installed by Homebrew and listed in the Brewfile.
_Avoid_: package (bare), brew

**Cask**:
A GUI application installed by Homebrew and listed in the Brewfile.
_Avoid_: package (bare), app

**Vendored skill**:
A third-party agent skill whose full contents are committed to the repo, so upstream changes arrive as reviewable diffs.
_Avoid_: plugin, installed skill

**Own skill**:
An agent skill written and maintained in this repo, not pulled from upstream.
_Avoid_: custom skill, local skill

### What the repo doesn't describe

**Drift**:
Any state on the Machine that the repo doesn't describe, such as a Formula installed by hand or a config file that replaced its symlink.
_Avoid_: cruft, leftovers

**Manual step**:
Setup the repo can't automate, kept as a checklist instead.
_Avoid_: TODO, prerequisite
