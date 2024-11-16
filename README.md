# Hyprland dotfiles

## Install requirement

> [!IMPORTANT]
> Make sure install chaotic aur

```bash
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
```

`/etc/pacman.conf`

```conf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
```

```bash
sudo pacman -S brightnessctl noto-fonts-emoji noto-fonts waybar bluez blueman xdg-desktop-portal-hyprland swww ttf-jetbrains-mono-nerd nautilus bibata-cursor-theme ttf-delugia-code swaync catppuccin-gtk-theme-mocha nwg-look brave-bin
paru -S whitesur-icon-theme
```
