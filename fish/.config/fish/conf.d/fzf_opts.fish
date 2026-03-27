# Use fd as fzf's file finder (respects .gitignore, faster than find)
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# fzf UI: Catppuccin Mocha colors, preview, layout
set -gx FZF_DEFAULT_OPTS "\
  --height 40% \
  --layout reverse \
  --border rounded \
  --info inline \
  --prompt '❯ ' \
  --pointer '▶' \
  --marker '✓' \
  --color 'bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4' \
  --color 'hl:#89b4fa,hl+:#89dceb,border:#585b70,separator:#585b70' \
  --color 'info:#cba6f7,prompt:#cba6f7,pointer:#f5c2e7,marker:#a6e3a1' \
  --color 'spinner:#f5c2e7,header:#89b4fa' \
  --bind 'ctrl-/:toggle-preview' \
  --bind 'ctrl-u:preview-page-up,ctrl-d:preview-page-down'"

# fzf.fish: use fd for directory and file searches
set -gx fzf_fd_opts '--hidden --follow --exclude .git'

# Move variable search off Ctrl+V → Ctrl+Alt+V, restore Ctrl+V as paste
fzf_configure_bindings --variables=\e\cv
bind \cv fish_clipboard_paste
