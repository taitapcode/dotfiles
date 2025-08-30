# Hyprland Dotfiles

Simple automated setup of my Hyprland environment on Arch-based systems.

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/taitapcode/dotfiles/hyprland/install.sh | bash
```

Alternative with `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/taitapcode/dotfiles/hyprland/install.sh | bash
```

## What The Script Does

- Chaotic AUR: Adds keyring + mirrorlist and enables `[chaotic-aur]` in `pacman.conf`.
- AUR helper: Installs `paru` and uses it for package installs.
- Dependencies: Installs core packages (Hyprland tools, fonts, bluetooth, theming, Wayland utilities, Fcitx5, panel, etc.).
- Dotfiles: Clones/uses this repo at `~/.hyprland` (skips if present).
- Symlinks: Uses `stow` to link configs into `~/.config`.
- Clock fix: Sets `timedatectl set-local-rtc 1` for Windows dual‑boot.

Packages installed include (non‑exhaustive):

`git`, `paru`, `noto-fonts(-cjk|-emoji)`, `bluez`, `bluez-utils`, `blueman`, `xdg-desktop-portal-hyprland`, `nautilus`, `bibata-cursor-theme`, `nwg-look`, `zen-browser`, `grim`, `wl-clipboard`, `hyprpicker`, `swww`, `swaync`, `waybar`, `rofi`, `fcitx5` (+ `unikey`, `gtk`, `configtool`), `ttf-delugia-code`, `catppuccin-gtk-theme-mocha`, `ags-hyprpanel-git`, `power-profiles-daemon`, `hyprsunset`.

## Requirements

- Arch-based distro with `sudo` and internet access.
- Shell: `bash`.
- Symlinking: `stow` is required for linking configs.

## After Installation

- Reboot: Many services and the clock setting apply after a reboot.
- Input method: Configure Fcitx5 as needed.
- Theming: Use `nwg-look` to apply the Catppuccin GTK theme and cursor.

## Troubleshooting

- Paru not found: The script installs it; if this fails, rerun the script after verifying Chaotic AUR steps completed.
- Stow not found: Install `stow` (see Requirements) and run `./install.sh` again, or run `stow .` inside `~/.hyprland`.
- Existing configs: The script removes `~/.config/hypr` before stowing. Back up any customizations in that path beforehand.

## Uninstall/Revert

- Remove symlinks by running `stow -D .` from `~/.hyprland`.
- Manually remove packages if desired using `paru -Rns <pkg>`.
