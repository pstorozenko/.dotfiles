# dotfiles

> [!NOTE]
> This setup was mostly generated with Claude Code so it won't be bullet proof.
> In particular the theme switching feature is still in progress.

Personal dotfiles for Fedora / KDE Plasma, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package    | What it configures                                       |
| ---------- | -------------------------------------------------------- |
| `fish`     | Shell config, functions, fzf/uv/nvm hooks                |
| `tmux`     | tmux config (Catppuccin theme, copycat, yank)            |
| `kitty`    | Terminal emulator (Catppuccin theme, JetBrainsMono NF)   |
| `starship` | Shell prompt                                             |
| `git`      | Global git config (delta pager, aliases)                 |
| `nvim`     | LazyVim config (Python, TS, JSON, prettier extras)       |
| `ripgrep`  | `~/.config/ripgrep/ripgreprc` defaults                   |
| `fd`       | `~/.fdignore` global ignores                             |
| `keyd`     | Keyboard remapping (`/etc/keyd/default.conf`)            |
| `scripts`  | `switch-theme` — syncs dark/light across all apps        |
| `systemd`  | `theme-watcher.service` — auto-syncs on KDE theme change |

---

## Useful CLI tools

| Tool        | What it does                                      |
| ----------- | ------------------------------------------------- |
| `yazi`      | Terminal file manager with image preview          |
| `btop`      | Resource monitor (CPU, mem, net, disk)            |
| `lazygit`   | TUI for git — stage, commit, rebase interactively |
| `bat`       | `cat` with syntax highlighting and git integration|
| `eza`       | `ls` replacement with colors, icons, tree view    |
| `fzf`       | General-purpose fuzzy finder                      |
| `zoxide`    | Smarter `cd` — jumps to frecent directories       |
| `jq`        | JSON processor for the command line               |

---

## Fresh install

### 1. Prerequisites

```bash
sudo dnf install -y \
  fish tmux kitty neovim \
  fzf fd-find ripgrep bat eza yazi \
  git-delta stow keyd gh \
  stow

# Starship (not in Fedora repos)
curl -sS https://starship.rs/install.sh | sh

# JetBrainsMono Nerd Font
mkdir -p ~/.local/share/fonts/JetBrainsMono
curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz" \
  | tar -xJ -C ~/.local/share/fonts/JetBrainsMono/
fc-cache -fv
```

### 2. Clone

```bash
git clone git@github.com:pitrosk/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 3. Stow

```bash
# User configs (symlinked into ~/)
stow fish tmux kitty starship git ripgrep fd nvim ssh scripts systemd

# Keyboard remapping (symlinked into /etc/)
sudo stow -t /etc keyd

# Seed runtime theme symlinks (default: dark)
ln -sf ~/.config/kitty/themes/mocha.conf ~/.config/kitty/current-theme.conf
ln -sf ~/.config/tmux/themes/mocha.conf  ~/.config/tmux/theme.conf
```

### 4. Post-install steps

Run these in order after stowing:

```bash
# 1. Set fish as default shell
chsh -s /usr/bin/fish

# 2. Restore fisher plugins (nvm.fish, fzf.fish, etc.)
fish -c "fisher update"

# 3. Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins
# or: open tmux and press prefix+I (Ctrl+a then Shift+i)

# 4. Start neovim — LazyVim will auto-install plugins on first launch
nvim

# 5. GitHub CLI auth
gh auth login
gh config set editor nvim

# 6. Enable keyd
sudo systemctl enable --now keyd
```

---

## Day-to-day

Since stow creates symlinks, **edits inside `~/.dotfiles/` take effect immediately** — no re-stow needed.

```bash
# Edit a config
nvim ~/.dotfiles/fish/.config/fish/config.fish   # change takes effect in next shell

# Add a new package (e.g. "zed")
mkdir -p ~/.dotfiles/zed/.config/zed
mv ~/.config/zed/settings.json ~/.dotfiles/zed/.config/zed/
cd ~/.dotfiles && stow zed
git add zed && git commit -m "add zed config"

# Remove a package
cd ~/.dotfiles && stow -D some-package
```

## keyd shortcuts

| Key                      | Action              |
| ------------------------ | ------------------- |
| `CapsLock` (hold)        | `Ctrl`              |
| `CapsLock` (tap)         | `Esc`               |
| `RightAlt` + `h/j/k/l`   | ←↓↑→ arrow keys     |
| `RightAlt` + `u/p`       | Home / End          |
| `RightAlt` + `i/o`       | Page Up / Page Down |
| `RightAlt` + `Backspace` | Delete              |

## tmux shortcuts

Prefix: `Ctrl+a` or `Alt+a`

| Keys               | Action           |
| ------------------ | ---------------- |
| `prefix + \|`      | Split horizontal |
| `prefix + -`       | Split vertical   |
| `prefix + h/j/k/l` | Navigate panes   |
| `prefix + r`       | Reload config    |
