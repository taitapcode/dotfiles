# My dotfiles

## Install A.U.R Helper (Yay)

```bash
sudo pacman -Sy --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Clone dotfiles and install GNU stow

```bash
sudo pacman -S stow
git clone https://github.com/taitapcode/dotfiles ~/.dotfiles
```

## Install shell (fish) and shell utilities

```bash
sudo pacman -S fish fzf zoxide bat eza fd starship
yay -S pfetch-rs
stow ~/.dotfiles/fish
stow ~/.dotfiles/pfetch
```

## Install starship

```bash
sudo pacman -S starship
stow ~/.dotfiles/starship
```

## Install terminal (kitty)

```bash
sudo pacman -S kitty
yay -S ttf-delugia-code
stow ~/.dotfiles/kitty
```

## Install lazygit

```bash
sudo pacman -S lazygit
stow ~/.dotfiles/lazygit
```

## Install tmux

```bash
sudo pacman -S tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
stow ~/.dotfiles/tmux
```

## Install neovim

```bash
sudo pacman -S neovim nodejs npm xclip
stow ~/.dotfiles/nvim
```

## Install yazi

```bash
sudo pacman -S yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf zoxide
stow ~/.dotfiles/yazi
```

## Install ranger

```bash
sudo pacman -S ranger
yay -S ueberzugpp
stow ~/.dotfiles/ranger
```
