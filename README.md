# Hyprland Dotfiles

A complete, automated Hyprland window manager setup for Arch-based systems. Includes configuration for Hyprland, HyprPanel, Rofi, Waybar, Swaync, and more, with a one-command installer.

## Features

- **Hyprland WM**: Tiling window manager configuration with keybindings and custom settings
- **HyprPanel**: Modern status bar and dashboard powered by AGS
- **Application Launchers**: Rofi for application launching and wofi backup
- **Notifications**: Swaync for system notifications
- **Input Method**: Fcitx5 with Unikey for Vietnamese input support
- **Theming**: Catppuccin Mocha color scheme with GTK theme and cursor
- **Wallpapers**: Automatic wallpaper management with swww
- **Utilities**: Screen capture, brightness control, color picker, sunset mode
- **Boot**: SDDM Astronaut theme and minegrub boot theme

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/taitapcode/dotfiles/hyprland/install.sh | bash
```

## Installation Steps

The installation script performs the following:

1. **Chaotic AUR Setup**: Adds Chaotic AUR repository keys and enables the repository
2. **AUR Helper**: Installs `paru` for AUR package management
3. **Core Dependencies**: Installs all required packages (see list below)
4. **Repository Clone**: Clones dotfiles to `~/.hyprland` and `~/.dotfiles`
5. **Configuration Sync**: Uses `stow` to symlink configs to `~/.config`
6. **System Configuration**:
   - Applies SDDM login theme
   - Installs and configures GRUB minegrub theme
   - Configures keyd for keyboard remapping (Capslock → Esc)
7. **Git Configuration**: Optionally sets up Git user email and name

## Essential Post-Installation Steps

1. **Reboot**: Required for services and system settings to take effect

   ```bash
   reboot
   ```

2. **Configure Theme**: Customize GTK theme and cursor

   ```bash
   nwg-look
   ```

3. **Set Input Method**: Configure Fcitx5 if using multiple languages

   ```bash
   fcitx5-configtool
   ```
