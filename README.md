# i3 dotfiles

## Add chaotic A.U.R

```bash
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
```

In `/etc/pacman.conf`

```apacheconf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
```

## Install dependencies

```bash
sudo pacman -S feh dunst picom brightnessctl blueman xcape \
ttf-jetbrains-mono-nerd polybar rofi noto-fonts-cjk noto-fonts-emoji noto-fonts \
whitesur-icon-theme dracula-gtk-theme bibata-cursor-theme paru firefox \
ibus ibus-bamboo-git
```

## Fix wrong time displayed due to dual boot setup

```bash
timedatectl set-local-rtc 1
```
