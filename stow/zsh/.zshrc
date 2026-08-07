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
export PATH="$PATH:$HOME/.local/opt/go/bin" # Go
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER=x86_64-linux-musl-gcc # Rust
# --- LANGUAGES

# --- ALIASES ---
# personal
alias javi="cd ~/repos/javi-cardenas"
alias boot="cd ~/repos/javi-cardenas/bootdotdev"
alias dotfiles="cd ~/repos/javi-cardenas/dotfiles && zed ."
alias dice="cd ~/repos/javi-cardenas/liars-dice && zed ."

# work
alias actions="cd ~/repos/javi-cardenas-ke/ke-actions"
alias ke="cd ~/repos/javi-cardenas-ke"
alias lib="cd ~/repos/javi-cardenas-ke/ke-libraries"
alias nova="cd ~/repos/javi-cardenas-ke/hei-nova"

# github
alias ghpr="gh pr create --fill"

# kubernetes
alias k="kubectl"
alias kgp="kubectl get pods -A -o wide"
alias kgs="kubectl get svc"
alias kl="kubectl logs"
alias ka="kubectl apply -f"
alias kp="kubectl port-forward"
alias mk="minikube"
alias z="zed"
alias loc="cloc . --vcs=git"
# --- ALIASES ---
