# --- SHELL ---
# zsh-completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi

autoload -Uz compinit
if [ "$(find ~/.zcompdump -mtime +1 2>/dev/null)" ]; then
    compinit -i
else
    compinit -C -i
fi

# zsh-autosuggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-history-substring-search
source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# prompt
eval "$(starship init zsh)"

export PATH="$HOME/bin:$PATH" # my bash scripts
# --- SHELL ---

# --- LANGUAGES ---
export PATH="$HOME/.local/bin:$PATH" # uv tools
export PATH="$PATH:$HOME/go/bin" # go install binaries
# --- LANGUAGES ---

# --- ALIASES ---
# personal
alias ls="ls -la"
alias reload="source ~/.zshrc"
alias z="zed"
alias loc="cloc . --vcs=git"

alias boot="cd ~/Developer/javi-cardenas/bootdotdev"
alias dotfiles="cd ~/Developer/javi-cardenas/dotfiles"
alias dice="cd ~/Developer/javi-cardenas/liars-dice"
alias javi="cd ~/Developer/javi-cardenas"
alias notes="cd ~/Documents/obsidian"
alias proton="cd ~/Library/CloudStorage/ProtonDrive-javicardenas@pm.me-folder"

alias pass="pass-cli"
alias unlock="pass session unlock"

# github
alias ghpr="gh pr create --fill-first"
alias ghjavi="open https://github.com/javi-cardenas?tab=repositories"
# --- ALIASES ---
