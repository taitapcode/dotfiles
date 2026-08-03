# Dotfiles

Declarative NixOS setup managed as a flake with home-manager, managed via `nh`.

## Rebuild & Verify

- Rebuild the current host: `nh os switch`
- Check the flake evaluates (no build): `nix flake check`
- Update lockfile: `nh os update`

## Folder Structure

```
.dotfiles/
├── flake.nix
├── assets/                 # Wallpapers (1.png, 2.png, 3.png) and README images
├── config/                 # Raw dotfiles, sourced by modules
│   ├── fcitx5/
│   │   ├── conf/           # classicui.conf, notifications.conf
│   │   ├── config
│   │   └── profile
│   ├── niri/
│   │   └── config.kdl
│   └── nvim/
│       ├── config/         # autocmds, keymaps, lsp, options
│       ├── helper/         # fcitx5, keymap, trailspace
│       ├── plugin/         # one file per plugin (blink-cmp, snacks, ...)
│       ├── snippets/       # cpp.json, markdown.json
│       ├── clang-format
│       └── stylua.toml
├── hosts/
│   ├── acer-aspire/        # configuration.nix, hardware.nix, home.nix
│   └── asus-tuf/           # configuration.nix, hardware.nix, home.nix
├── modules/
│   ├── home-manager/
│   │   ├── app/            # anki, ghostty, mpv, qbittorrent, vesktop, ...
│   │   ├── desktop/
│   │   │   ├── niri.nix
│   │   │   └── shell/
│   │   │       └── noctalia.nix
│   │   ├── programs/       # bat, fish, git, nvim, opencode, tmux, ...
│   │   └── default.nix
│   └── nixos/
│       ├── program/        # fcitx5, localsend, steam, waydroid
│       ├── service/        # keyd, sddm
│       └── default.nix
└── scripts/                # note.sh, rcc.sh (flake packages)
```

## Repository Structure

- `flake.nix` — Flake entrypoint. Defines `x86_64-linux` configs for `acer-aspire` and `asus-tuf`; `asus-tuf` imports `nixos-hardware.nixosModules.asus-fa506nc`. Also packages the scripts (`note`, `rcc`).
- `hosts/<host>/` — Per-machine config: `configuration.nix` (NixOS), `hardware.nix`, `home.nix` (home-manager).
- `modules/` — Shared modules, imported by hosts:
  - `nixos/` — system-level (`program/`, `service/`)
  - `home-manager/` — user-level: `programs/` (fish, nvim, git, tmux, opencode, fcitx5, ...), `app/` (zen-browser, ghostty, mpv, ...), `desktop/` (niri, shell)
- `config/` — Raw dotfiles, sourced by modules via `self + "/config/..."` (nvim lua config, niri kdl, fcitx5). See `modules/home-manager/programs/nvim.nix`, `desktop/niri.nix`, `programs/fcitx5.nix`.
- `scripts/` — Shell scripts packaged as flake packages (`note.sh`, `rcc.sh`).
- `assets/` — Wallpapers and README images.

## Conventions

- Home-manager modules follow the pattern: `options.modules.home.programs.<name>.enable = lib.mkEnableOption ...` then `config = lib.mkIf cfg.enable { ... }`, imported via `modules/home-manager/default.nix`. NixOS modules use `modules.nixos.*`.
- Hosts enable modules declaratively (e.g. `modules.home.programs.fish.enable = true;` in `hosts/*/home.nix`).
- Username is `tai`, home dir `/home/tai`, state version `26.05`. `nh` is configured with `flake = /home/${config.home.username}/.dotfiles`.
- Theme is Catppuccin Mocha (accent blue), enabled in `hosts/*/home.nix`.
- Format Nix code with nixfmt; keep modules small and single-purpose (one file per program).
