#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="https://github.com/taitapcode/dotfiles.git"
NIRI_BRANCH="niri"
NIRI_DIR="$HOME/.niri"

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
    base-devel
    git
    stow
    noto-fonts-emoji
    noto-fonts
    noto-fonts-cjk
    xdg-desktop-portal-hyprland
    brightnessctl
    nautilus
    bibata-cursor-theme
    zen-browser
    fcitx5
    fcitx5-gtk
    fcitx5-configtool
    github-cli
    sxiv
    mpv
    cava
    matugen
    sddm-astronaut-theme
    keyd

    # AUR packages
    ttf-delugia-code
    power-profiles-daemon
    fcitx5-vmk-bin
    dms-shell-bin
  )
  install_pkgs "${deps[@]}"
}

clone_niri_dotfiles() {
  echo "Cloning niri dotfiles repo..."
  if [[ -d "$NIRI_DIR" ]]; then
    echo "Dotfiles directory already exists at $NIRI_DIR. Skipping clone."
    return 0
  fi
  git clone "$REPO_URL" -b "$NIRI_BRANCH" "$NIRI_DIR" --depth 1
}

apply_vmk_config() {
  echo "Applying VMK keyboard layout configuration..."
  sudo systemctl enable --now fcitx5-vmk-server@$(whoami).service
}

config_skip_review_paru() {
  echo "SkipReview" | sudo tee -a /etc/paru.conf
}

config_git() {
  echo -n "Do you want to configure Git now? (Y/n): "
  read -r response
  if [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Skipping Git configuration."
    return 0
  fi
  echo -n "Enter your Git user email: "
  read -r email
  git config --global user.email "$email"
  echo -n "Enter your Git user name: "
  read -r name
  git config --global user.name "$name"
}

apply_grub_config() {
  git clone https://github.com/Lxtharia/minegrub-theme.git --depth 1 ~/minegrub-theme
  cd ~/minegrub-theme
  sudo ./install_theme.sh
  cd
  rm -rf ~/minegrub-theme
  echo 'GRUB_THEME=/boot/grub/themes/minegrub/theme.txt' | sudo tee /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}

apply_sddm_config() {
  echo -e "[Theme]\nCurrent=sddm-astronaut-theme" | sudo tee /etc/sddm.conf
  sudo mkdir -p /etc/sddm.conf.d
  echo -e "[General]\nInputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf
  sudo sed -i "9s#.*#ConfigFile=Themes/pixel_sakura.conf#" /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
}

apply_keyd_config() {
  sudo systemctl enable --now keyd
  echo "[ids]

*

[main]

# Maps capslock to escape when pressed and control when held.
# capslock = overloadt(control, esc, 150)

# Remaps capslock to escape
capslock = esc

# Remaps the escape key to capslock
esc = capslock" | sudo tee /etc/keyd/default.conf
  sudo keyd reload

  echo "#!/bin/sh
if [ \"\${1}\" = \"post\" ]; then
    sleep 1
    systemctl restart keyd
fi" | sudo tee /lib/systemd/system-sleep/keyd-restart
  sudo chmod +x /lib/systemd/system-sleep/keyd-restart
}

sync_niri_config() {
  echo "Syncing configuration with stow..."
  cd "$NIRI_DIR" || exit 1
  stow .
}

main() {
  install_chaoticaur_and_AUR_helper
  install_dependencies
  apply_vmk_config
  config_skip_review_paru
  config_git
  apply_grub_config
  apply_sddm_config
  apply_keyd_config
  clone_niri_dotfiles
  sync_niri_config
  echo "Installation complete! Please restart your system."
  echo "To install my dotfiles, run this command:"
  echo "git clone https://github.com/taitapcode/dotfiles --depth 1 ~/.dotfiles && cd ~/.dotfiles && chmod +x install.sh && ./install.sh"

}

main
