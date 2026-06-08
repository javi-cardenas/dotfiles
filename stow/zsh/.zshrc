# FPATH="/opt/homebrew/share/zsh-completions:${FPATH}"

# autoload -Uz compinit && compinit

# source "/opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
# bindkey '^[OA' history-substring-search-up
# bindkey '^[OB' history-substring-search-down

# source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# eval "$(starship init zsh)"

# source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Zsh completions
autoload -Uz compinit
if [ "$(find ~/.zcompdump -mtime +1 2>/dev/null)" ]; then
    compinit -i
else
    compinit -C -i  # -C skips the security scan using the cached dump
fi

# Zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Generated for envman. Do not edit. Go from webi
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH=$PATH:$HOME/.local/opt/go/bin

# Aliases
alias k="kubectl"
alias kgp="kubectl get pods -A -o wide" # get all pods info
alias kgs="kubectl get svc" # get all services info
alias kl="kubectl logs" # get the pod logs
alias ka="kubectl apply -f" # apply a yaml file
alias kp="kubectl port-forward" # port forward a pod

alias mk="minikube"
alias z="zed"

alias javi="cd && cd repos/javi-cardenas/"
alias dotfiles="cd && cd repos/javi-cardenas/dotfiles"
alias boot="cd && cd repos/javi-cardenas/bootdotdev"

alias ke="cd && cd repos/javi-cardenas-ke/"
alias lib="cd && cd repos/javi-cardenas-ke/ke-libraries"
alias actions="cd && cd repos/javi-cardenas-ke/ke-actions"
alias nova="cd && cd repos/javi-cardenas-ke/hei-nova"
alias dotfiles="cd ~/repos/javi-cardenas/dotfiles && zed ."

source <(kubectl completion zsh)
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER=x86_64-linux-musl-gcc
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER=x86_64-linux-musl-gcc
