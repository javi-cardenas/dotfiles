# on an SSH login, attach to the "main" tmux session, creating it if needed, so a dropped connection picks up where it left off
# detaching (prefix + d) ends the SSH session, `ssh -t <host> zsh` skips tmux
if [[ -n "$SSH_CONNECTION" && -z "$TMUX" && -o login && -t 0 && -t 1 ]] && command -v tmux &>/dev/null; then
    infocmp "$TERM" &>/dev/null || export TERM=xterm-256color # Ghostty and cmux send xterm-ghostty, which other Macs may not know
    tmux new-session -A -s main && exit # falls through to a plain shell if tmux fails
fi
