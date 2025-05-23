# My dotfiles

## Clone dotfiles and install GNU stow

```bash
sudo pacman -S stow
git clone https://github.com/taitapcode/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

## Install fish shell and shell utilities

```bash
sudo pacman -S fish fzf zoxide bat eza fd
stow fish
```

## Install starship

```bash
sudo pacman -S starship
stow starship
```

## Install kitty terminal

```bash
sudo pacman -S kitty
yay -S ttf-delugia-code
stow kitty
```

## Install ghostty terminal

```bash
sudo pacman -S ghostty
paru -S ttf-delugia-code
stow ghostty
```

## Install lazygit

```bash
sudo pacman -S lazygit
stow lazygit
```

## Install tmux

```bash
sudo pacman -S tmux
stow tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install neovim

```bash
sudo pacman -S neovim nodejs npm xclip unzip wl-clipboard curl
stow nvim
```

## Install yazi

```bash
sudo pacman -S yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf zoxide
stow yazi
```
