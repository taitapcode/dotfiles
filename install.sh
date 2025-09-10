#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="https://github.com/taitapcode/dotfiles.git"
HYPRLAND_BRANCH="hyprland"
DOTFILES_BRANCH="hyprland"
HYPRLAND_DIR="$HOME/.hyprland"
DOTFILES_DIR="$HOME/.dotfiles"

install_pkgs() {
  if [[ $# -lt 1 ]]; then
    echo "usage: install_pkgs <pkg> [pkg2 ...]" >&2
    return 2
  fi

  # Ensure paru exists
  command -v paru >/dev/null 2>&1 || {
    echo "Error: paru not found on PATH." >&2
    return 127
  }

  local -a missing=()
  local pkg
  for pkg in "$@"; do
    if ! pacman -Q "$pkg" &>/dev/null; then
      missing+=("$pkg")
    else
      echo "$pkg is already installed."
    fi
  done

  if ((${#missing[@]} == 0)); then
    echo "All packages are already installed."
    return 0
  fi

  local -a opts=(--needed --noconfirm)

  echo "Installing: ${missing[*]}"
  paru -Sy "${opts[@]}" "${missing[@]}"
}

install_chaoticaur_and_AUR_helper() {
  echo "Install Chaotic AUR..."
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst" --noconfirm
  sudo pacman -U "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst" --noconfirm
  if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
  fi
  sudo pacman -Sy paru --needed --noconfirm
}

install_dependencies() {
  echo "Installing dependencies..."
  local deps=(
    git
    stow
    noto-fonts-emoji
    noto-fonts
    noto-fonts-cjk
    bluez
    bluez-utils
    xdg-desktop-portal-hyprland
    brightnessctl
    nautilus
    bibata-cursor-theme
    nwg-look
    zen-browser
    grim
    wl-clipboard
    hyprpicker
    swww
    # swaync
    waybar
    rofi-wayland
    sddm-astronaut-theme
    fcitx5
    fcitx5-unikey
    fcitx5-gtk
    fcitx5-configtool
    github-cli
    sxiv

    # AUR packages
    ttf-delugia-code
    catppuccin-gtk-theme-mocha
    ags-hyprpanel-git
    power-profiles-daemon
    hyprsunset
  )
  install_pkgs "${deps[@]}"
}

remove_unused_pkgs() {
  pkgs=(
    dunst
    network-manager-applet
  )

  paru -Rns "${pkgs[@]}" --noconfirm
}

clone_hyprland_dotifles() {
  echo "Cloning hyprland dotfiles repo..."
  if [[ -d "$HYPRLAND_DIR" ]]; then
    echo "Dotfiles directory already exists at $HYPRLAND_DIR. Skipping clone."
    return 0
  fi
  git clone "$REPO_URL" -b "$HYPRLAND_BRANCH" "$HYPRLAND_DIR" --depth 1
}

clone_dotfiles() {
  echo "Cloning dotfiles repo..."
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "Dotfiles directory already exists at $DOTFILES_DIR. Skipping clone."
    return 0
  fi
  git clone "$REPO_URL" -b "$DOTFILES_BRANCH" "$DOTFILES_DIR" --depth 1
}

sync_hyprland_config() {
  echo "Syncing configuration with stow..."
  cd "$HYPRLAND_DIR" || exit 1
  rm -rf "$HOME/.config/hypr" && stow .
}

sync_dotfiles() {
  echo "Syncing dotfiles with stow..."
  cd "$DOTFILES_DIR" || exit 1
}

apply_sddm_config() {
  echo -e "[Theme]\nCurrent=sddm-astronaut-theme" | sudo tee /etc/sddm.conf
  sudo mkdir -p /etc/sddm.conf.d
  echo -e "[General]\nInputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf
  sudo sed -i "9s#.*#ConfigFile=Themes/hyprland_kath.conf#" /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
}

apply_grub_config() {
  git clone https://github.com/Lxtharia/minegrub-theme.git --depth 1 ~/minegrub-theme
  cd ~/minegrub-theme
  sudo ./install_theme.sh
  cd ..
  rm -rf ~/minegrub-theme
}

fix_dualboot_time() {
  echo "Fixing dual boot time issue..."
  sudo timedatectl set-local-rtc 1 --adjust-system-clock
}

main() {
  install_chaoticaur_and_AUR_helper
  install_dependencies
  clone_hyprland_dotifles
  clone_dotfiles
  sync_hyprland_config
  apply_sddm_config
  apply_grub_config
  fix_dualboot_time
  sync_dotfiles
  echo "Installation complete! Please restart your system."
}

main
