# My Dotfiles ✨

## Prerequisites 🛠️

```bash
sudo pacman -S stow
git clone https://github.com/taitapcode/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

## Installation 🚀

You can use the automated installer:

```bash
cd ~/.dotfiles
chmod +x install.sh
./install.sh --all
# or pick modules
./install.sh fish nvim tmux
```

### Fish Shell and Utilities 🐚

```bash
sudo pacman -S fish fzf zoxide bat eza fd
stow fish
```

### Starship ⭐️

```bash
sudo pacman -S starship
stow starship
```

### Kitty Terminal 🐱

```bash
sudo pacman -S kitty
paru -S ttf-delugia-code
stow kitty
```

### Ghostty Terminal 👻

```bash
sudo pacman -S ghostty
paru -S ttf-delugia-code
stow ghostty
```

### Lazygit branch

```bash
sudo pacman -S lazygit
stow lazygit
```

### Tmux Multiplexer 🪟

```bash
sudo pacman -S tmux
stow tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Neovim Editor 📝

```bash
sudo pacman -S neovim nodejs npm xclip unzip wl-clipboard curl uv tree-sitter-cli
stow nvim
```

### Yazi TUI File Manager 📁

```bash
sudo pacman -S yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf zoxide 7zip
stow yazi
```
