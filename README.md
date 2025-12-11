# Dotfiles

## Install

```bash
git clone https://github.com/taitapcode/dotfiles --depth 1 ~/.dotfiles
cd ~/.dotfiles && chmod +x install.sh && ./install.sh
```

Or specific modules:

```bash
./install.sh fish nvim tmux
```

## Options

```bash
./install.sh --all              # All modules
./install.sh --dry-run          # Preview
./install.sh --set-default-shell # Set fish as default
./install.sh --no-aur           # Skip AUR packages
```

## Requirements

- `stow`
- `pacman` + AUR helper (`paru`/`yay`)
- `git`
