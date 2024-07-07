# My dotfiles

## Clone dotfiles and install GNU stow

```bash
sudo pacman -S stow
git clone https://github.com/taitapcode/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

## Install shell (fish) and shell utilities

```bash
sudo pacman -S fish fzf zoxide bat eza fd
stow fish
```

## Install starship

```bash
sudo pacman -S starship
stow starship
```

## Install terminal (kitty)

```bash
sudo pacman -S kitty
yay -S ttf-delugia-code
stow kitty
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
sudo pacman -S neovim nodejs npm xclip unzip
stow nvim
```

## Install yazi

```bash
sudo pacman -S yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf zoxide
stow yazi
```

## Install ranger

```bash
sudo pacman -S ranger
yay -S ueberzugpp
stow ranger
```
