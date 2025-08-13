# Hyprland Dotfiles

## Installation Requirements

> [!IMPORTANT]
> Ensure you have the Chaotic AUR installed.

```bash
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
```

```conf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
```

Finally, install the required packages:

```bash
sudo pacman -S paru brightnessctl noto-fonts-emoji noto-fonts noto-fonts-cjk waybar bluez blueman xdg-desktop-portal-hyprland swww ttf-jetbrains-mono-nerd nautilus bibata-cursor-theme swaync nwg-look hy3 fcitx5-config-qt fcitx5 fcitx5-qt fcitx5-gtk fcitx5-unikey zen-browser
paru -S ttf-delugia-code whitesur-icon-theme catppuccin-gtk-theme-mocha
timedatectl set-local-rtc 1
```
