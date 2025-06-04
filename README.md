# My Dotfiles

## Prerequisites

```bash
sudo pacman -S stow
git clone https://github.com/taitapcode/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

## Installation

### Fish Shell and Utilities

```bash
sudo pacman -S fish fzf zoxide bat eza fd
stow fish
```

### Starship

```bash
sudo pacman -S starship
stow starship
```

### Kitty Terminal

```bash
sudo pacman -S kitty
yay -S ttf-delugia-code
stow kitty
```

### Ghostty Terminal

```bash
sudo pacman -S ghostty
paru -S ttf-delugia-code
stow ghostty
```

### Lazygit

```bash
sudo pacman -S lazygit
stow lazygit
```

### Tmux

```bash
sudo pacman -S tmux
stow tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Neovim

```bash
sudo pacman -S neovim nodejs npm xclip unzip wl-clipboard curl
stow nvim
```

### Yazi

```bash
sudo pacman -S yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf zoxide
stow yazi
```
