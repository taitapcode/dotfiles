# Installation for arch linux distro

> [!NOTE]
> Make sure you installed `git`

## Clone repositories

```bash
git clone https://github.com/taitapcode/dotfiles.git ~/dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install packages with pacman

```bash
sudo pacman -Sy - < ~/dotfiles/pkgslist.txt
```

## Install AUR helper (yay)

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Install AUR packages

```bash
yay -S - < ~/dotfiles/aur-pkgslist.txt
```

## Set fish as default shell

```bash
chsh -s $(which fish)
```

## Setup your config files

```bash
cd ~/dotfiles
stow .
```
