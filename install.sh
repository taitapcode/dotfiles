#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

TARGET_DIR="$HOME"
PACMAN_CMD=${PACMAN_CMD:-pacman}
SUDO_CMD=${SUDO_CMD:-sudo}
STOW_FLAGS=${STOW_FLAGS:-}

DRY_RUN=false
USE_AUR=true
SET_DEFAULT_SHELL=false

modules=(fish starship kitty ghostty lazygit tmux nvim yazi)
selected_modules=()

msg() { printf "\033[1;32m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[warn]\033[0m %s\n" "$*"; }
err() { printf "\033[1;31m[err ]\033[0m %s\n" "$*" 1>&2; }

run() {
  if $DRY_RUN; then
    printf "[dry] %s\n" "$*"
  else
    eval "$@"
  fi
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

ensure_pacman() {
  if ! need_cmd "$PACMAN_CMD"; then
    err "This installer targets Arch Linux (requires pacman)."
    exit 1
  fi
}

pacman_install() {
  local pkgs=("$@")
  if [ ${#pkgs[@]} -eq 0 ]; then return 0; fi
  msg "Installing via pacman: ${pkgs[*]}"
  run "$SUDO_CMD" "$PACMAN_CMD" -S --needed --noconfirm "${pkgs[@]}"
}

aur_helper() {
  if need_cmd paru; then
    echo paru
    return 0
  fi
  if need_cmd yay; then
    echo yay
    return 0
  fi
  return 1
}

aur_install() {
  local pkgs=("$@")
  if [ ${#pkgs[@]} -eq 0 ]; then return 0; fi
  if ! $USE_AUR; then
    warn "Skipping AUR packages (disabled): ${pkgs[*]}"
    return 0
  fi
  local helper
  if ! helper=$(aur_helper); then
    warn "No AUR helper (paru/yay) found; skipping: ${pkgs[*]}"
    return 0
  fi
  msg "Installing via ${helper}: ${pkgs[*]}"
  run "$helper" -S --needed --noconfirm "${pkgs[@]}"
}

do_stow() {
  local dir="$1"
  if [ ! -d "$REPO_DIR/$dir" ]; then
    warn "Missing module directory: $dir (skipping)"
    return 0
  fi
  msg "Stowing $dir -> $TARGET_DIR"
  run stow -v -t "$TARGET_DIR" $STOW_FLAGS "$dir"
}

install_fish() {
  pacman_install fish fzf zoxide bat eza fd
  do_stow fish
  if $SET_DEFAULT_SHELL; then
    if chsh -s "$(command -v fish)" "$USER"; then
      msg "Default shell switched to fish for $USER"
    else
      warn "Failed to change default shell; you may need to run: chsh -s \"$(command -v fish)\" $USER"
    fi
  fi
}

install_starship() {
  pacman_install starship
  do_stow starship
}

install_kitty() {
  pacman_install kitty
  aur_install ttf-delugia-code
  do_stow kitty
}

install_ghostty() {
  pacman_install ghostty || warn "ghostty may be unavailable on your repo; skipping if not found."
  aur_install ttf-delugia-code
  do_stow ghostty
}

install_lazygit() {
  pacman_install lazygit
  do_stow lazygit
}

install_tmux() {
  pacman_install tmux git
  do_stow tmux
  # Install TPM if missing
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [ ! -d "$tpm_dir" ]; then
    msg "Cloning tmux plugin manager (TPM)"
    run git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  else
    msg "TPM already present"
  fi
}

install_nvim() {
  pacman_install neovim nodejs npm xclip unzip wl-clipboard curl uv tree-sitter-cli
  do_stow nvim
}

install_yazi() {
  # Prefer '7zip' package; fall back to p7zip on older repos
  local seven_zip_pkg="7zip"
  if ! pacman -Si 7zip >/dev/null 2>&1; then
    seven_zip_pkg="p7zip"
  fi
  pacman_install yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf zoxide "$seven_zip_pkg"
  do_stow yazi
}

usage() {
  cat <<EOF
Usage: ./install.sh [options] [modules]

Modules:
  ${modules[*]}

Options:
  --all                 Install/stow all modules (default if none specified)
  --no-aur              Skip installing AUR packages (e.g., fonts)
  --dry-run             Print actions without executing
  --set-default-shell   Run chsh to set fish as default shell (if selected)
  --target DIR          Stow target directory (default: \$HOME)
  --stow-flags FLAGS    Extra flags passed to stow
  -h, --help            Show this help

Examples:
  ./install.sh --all
  ./install.sh fish nvim tmux
  ./install.sh --no-aur kitty
EOF
}

parse_args() {
  if [ $# -eq 0 ]; then
    selected_modules=("--all")
  else
    selected_modules=("$@")
  fi
  local parsed=()
  while [ $# -gt 0 ]; do
    case "$1" in
    --all)
      parsed=("${modules[@]}")
      shift
      ;;
    --no-aur)
      USE_AUR=false
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --set-default-shell)
      SET_DEFAULT_SHELL=true
      shift
      ;;
    --target)
      TARGET_DIR="$2"
      shift 2
      ;;
    --stow-flags)
      STOW_FLAGS="$2"
      shift 2
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    -*)
      err "Unknown option: $1"
      usage
      exit 1
      ;;
    *)
      parsed+=("$1")
      shift
      ;;
    esac
  done
  # If no explicit modules except flags were given, default to all
  if [ ${#parsed[@]} -eq 0 ]; then
    parsed=("${modules[@]}")
  fi
  selected_modules=("${parsed[@]}")
}

main() {
  parse_args "$@"
  ensure_pacman
  if ! need_cmd stow; then
    msg "Installing stow"
    pacman_install stow
  fi
  msg "Modules selected: ${selected_modules[*]}"
  for m in "${selected_modules[@]}"; do
    case "$m" in
    fish) install_fish ;;
    starship) install_starship ;;
    kitty) install_kitty ;;
    ghostty) install_ghostty ;;
    lazygit) install_lazygit ;;
    tmux) install_tmux ;;
    nvim) install_nvim ;;
    yazi) install_yazi ;;
    *) warn "Unknown module: $m (skipping)" ;;
    esac
  done
  msg "Done. You may need to restart your terminal/session."
}

main "$@"
