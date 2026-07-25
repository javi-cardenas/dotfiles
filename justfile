default:
    @./scripts/list.sh

brew profile="":
    @./scripts/brew.sh "{{profile}}"

finder:
    @./scripts/finder.sh

stow:
    @./scripts/stow.sh

unstow:
    @./scripts/unstow.sh

update profile="":
    @./scripts/update.sh "{{profile}}"
