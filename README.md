# i3 dotfiles

## Add chaotic aur

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

## Install pkgs

```bash
sudo pacman -S feh dunst picom brightnessctl blueman \
ttf-jetbrains-mono-nerd polybar rofi noto-fonts-cjk noto-fonts-emoji noto-fonts \
whitesur-icon-theme dracula-gtk-theme bibata-cursor-theme yay
```
