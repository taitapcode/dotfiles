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
sudo pacman -S paru brightnessctl noto-fonts-emoji noto-fonts noto-fonts-cjk bluez bluez-utils blueman xdg-desktop-portal-hyprland swww ttf-jetbrains-mono-nerd nautilus bibata-cursor-theme swaync nwg-look hy3 fcitx5 fcitx5-unikey fcitx5-gtk fcitx5-qt fcitx5-configtool zen-browser grim wl-clipboard hyprpicker grimblast-git rofi
paru -S ttf-delugia-code catppuccin-gtk-theme-mocha ags-hyprpanel-git python python-gpustat pacman-contrib power-profiles-daemon
timedatectl set-local-rtc 1
localectl set-x11-keymap us pc105 "" caps:swapescape
```
