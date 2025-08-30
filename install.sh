#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="https://github.com/taitapcode/dotfiles"
branch="hyprland"
DOTFILES_DIR="$HOME/.hyprland"
DRY=0

log() { printf "%s\n" "$*" >&2; }
warn() { printf "⚠️ %s\n" "$*" >&2; }
die() {
  printf "❌ %s\n" "$*" >&2
  exit 1
}

run() {
  if ((DRY)); then
    log "🚀 [dry-run] %s\n" "$*" >&2
  else
    "$@"
  fi
}

help() {
  cat <<'USAGE'
Usage: install.sh [options]

Options:
  -h, --help            Show this help and exit
  -n, --dry-run         Print actions without executing
  -v, --verbose         Enable verbose output
USAGE
}

backup_file() {
  log "Backing up existing dotfiles..."
  if [[ -d "$DOTFILES_DIR" ]]; then
    local timestamp
    timestamp=$(date +%Y%m%d%H%M%S)
    local backup_dir="${DOTFILES_DIR}_backup_${timestamp}"
    run mv "$DOTFILES_DIR" "$backup_dir"
    log "Existing directory moved to $backup_dir"
  fi
}

install_chaotic_aur() {
  log "Installing Chaotic AUR repository..."

  run sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  run sudo pacman-key --lsign-key 3056513887B78AEB
  run sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
  run sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

  # Thêm block một lần
  if ! grep -q '^\[chaotic-aur\]' /etc/pacman.conf; then
    run printf '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n' | sudo tee -a /etc/pacman.conf >/dev/null
  fi

  run sudo pacman -Syu --noconfirm
}

clone_dotfiles() {
  run git clone --depth 1 --branch "$branch" "$REPO_URL" "$DOTFILES_DIR"
}

getargs() {
  # Manual parser supporting short and long options
  while (($#)); do
    case "$1" in
    -h | --help)
      help
      exit 0
      ;;
    -n | --dry-run)
      DRY=1
      shift
      continue
      ;;
    -v | --verbose)
      set -x
      shift
      continue
      ;;
    --)
      shift
      break
      ;;
    -*)
      die "Unknown option: $1"
      ;;
    *)
      # Positional arg (unused currently). Stop parsing if needed.
      break
      ;;
    esac
  done
}

main() {
  getargs "$@"
  backup_file
  install_chaotic_aur
  clone_dotfiles
}

main "$@"
