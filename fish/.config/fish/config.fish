if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.local/bin

# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# ripgrep config
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc

# Auto-attach to persistent tmux session when opening a terminal (not already in tmux)
if status is-interactive
    and not set -q TMUX
    and not set -q SSH_TTY
    # Attach to existing "main" session or create it
    tmux new-session -A -s main
end

# zoxide (smarter cd — use 'z' instead of 'cd')
zoxide init fish | source

# Starship prompt
starship init fish | source
