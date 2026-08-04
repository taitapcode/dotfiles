# Dotfiles

Declarative NixOS setup managed as a flake with home-manager, managed via `nh`.

## Rebuild & Verify

Both hosts use hostname `nixos`, so `nh` can't infer which configuration to build from that — always pass `-H <flake-attr>` (the `nixosConfiguration` name, `asus-tuf` or `acer-aspire`), e.g. `nh os build -H asus-tuf` or `nh os switch -H asus-tuf`.

- Check the flake evaluates (no build): `nix flake check`
- Update lockfile: `nh os update`
- Build (dry run, no switch): `nh os build -H <host>`
- Switch to the current machine config: `nh os switch -H <host>`

## Flake

`flake.nix` is the entrypoint. `system = "x86_64-linux"`.

- `nixpkgs` is pinned to `nixos-unstable`. All other inputs follow it so the whole tree builds from one nixpkgs.
- Inputs: `catppuccin`, `nixos-hardware`, `home-manager`, `noctalia` (full shell, DSL config via `programs.noctalia.settings`), `zen-browser` (flake also follows our `home-manager`), `fcitx5-lotus` (pulls in snowfall-lib).
- Outputs:
  - `packages.${system}.note` / `.rcc` — flake packages wrapping `scripts/note.sh` / `scripts/rcc.sh` via `writeShellApplication`.
  - `nixosConfigurations.acer-aspire` and `nixosConfigurations.asus-tuf`, both with `specialArgs = { inherit inputs self; }` + `home-manager.nixosModules.default`. `asus-tuf` additionally imports `nixos-hardware.nixosModules.asus-fa506nc`.
- Enable auto-chains: `modules.home.programs.fish` also enables `fzf`, `zoxide`, `yazi`; `modules.home.desktop.niri` also enables `desktop.shell.noctalia`.

## Folder Structure

```
.dotfiles/
├── flake.nix
├── assets/                 # profile.jpg (Noctalia avatar), screenshot.png, wallpapers/{1,2,3}.png
├── config/                 # Raw dotfiles, sourced by modules via `self + "/config/..."`
│   ├── fcitx5/
│   │   ├── conf/           # classicui.conf, notifications.conf
│   │   ├── config          # trigger Alt+Z, page Up/Down
│   │   └── profile         # DefaultIM = lotus
│   ├── niri/
│   │   └── config.kdl      # ~292 lines: layout, binds, noctalia/ghostty window rules
│   └── nvim/
│       ├── config/         # autocmds, cmds, keymaps, lsp, options (readFile into initLua)
│       ├── helper/         # fcitx5, keymap, trailspace
│       ├── plugin/         # one file per plugin (18 plugins, incl. blink-cmp, snacks)
│       ├── snippets/       # cpp.json, markdown.json
│       ├── clang-format    # Google base, Allman braces, indent 2
│       └── stylua.toml     # 2 spaces, 120 col, single quotes
├── hosts/
│   ├── acer-aspire/        # Intel laptop
│   └── asus-tuf/           # ASUS TUF F15 (FA506NC, NVIDIA) - the primary machine
├── modules/
│   ├── home-manager/       # see "Home-Manager Modules" below
│   └── nixos/              # see "NixOS Modules" below
└── scripts/
    ├── note.sh             # git-backed notes helper
    └── rcc.sh              # compile+run+delete a C++17 file
```

## Hosts

Both hosts share the same `home.nix` (catppuccin mocha/blue, xdg.mimeApps defaults, all app+program modules enabled); differences are in `configuration.nix`.

Common to both: GRUB+EFI, TZ `Asia/Ho_Chi_Minh`, hostname `nixos`, user `tai` (shell fish), pipewire+pulse, printing (cups), bluetooth, `libinput`, `upower`, `xdg-desktop-portal-gnome`, NetworkManager, `nix-command`+`flakes`, fonts (noto cjk, ubuntu, caskaydia-cove + jetbrains-mono nerdfonts), state version `26.05`. Modules enabled on both: `modules.nixos.service.{keyd,sddm}`, `modules.nixos.program.{fcitx5,waydroid,steam}`.

- **asus-tuf** (FA506NC) — **primary/actively used machine**; build/test with `nh os switch` here by default. Imports nixos-hardware `asus-fa506nc`; NVIDIA (modesetting, powerManagement, nvidiaPersistenced), `acpi_backlight=native`, `services.asusd` (charge limit 80%, profile linked to power), `/mnt/Storage` NTFS, `modules.nixos.program.localsend`; also enables system-level catppuccin module (mocha+blue, autoEnable).
- **acer-aspire** (Intel): **no longer used** — kept for reference/backup only; do not rely on it. GRUB+EFI, `power-profiles-daemon`, swap, NTFS `/mnt/games`, Intel microcode, `kvm-intel`.

## Home-Manager Modules

`modules/home-manager/default.nix` imports `./app ./programs ./desktop`. Option namespace: `modules.home.*`. Enabled modules (from `hosts/*/home.nix`) use the pattern `options.modules.home.programs.<name>.enable = lib.mkEnableOption ...`.

`programs/`:
- `fish` — fish w/ custom prompt (git branch + dirty ✗), aliases (`ll`, `la`, `cat`→bat, `v`→nvim, `tmx`, `lg`, ...), `fifc` plugin, vi bindings; **auto-enables fzf, zoxide, yazi**.
- `fcitx5` — session vars (`GTK_IM_MODULE`, `QT_IM_MODULE`, `XMODIFIERS`), sources `config/fcitx5`.
- `fzf` — preview widgets w/ bat/eza (also pulls bat, eza, ripgrep, fd).
- `git` — user `taitapcode` (hoangductai2007@gmail.com), `init.defaultBranch=main`, `pull.rebase`; pulls `gh` (https) + `lazygit` (icons).
- `nvim` — `vim`/`vi` aliases; ~18 plugins with per-file lua config from `config/nvim/plugin/`, 8 LSP servers (nixd, lua_ls, fish_lsp, clangd, basedpyright, bashls, gdscript, copilot), formatters via conform; uses `builtins.readFile` to inline all `config/`+`helper/` lua into `initLua`.
- `tmux` — prefix `C-s`, vi mode, mouse, catppuccin mocha status bar, M-H/M-L window nav, `n`/`f` split-pane note binds.
- `opencode` — LSP servers (nixd, clangd, bashls, ...), session-renamed plugin.
- `bat`, `eza` (icons, group-directories-first), `bun`, `mangohud`, `kanshi` (2 output profiles: laptop builtin 1920×1080@144, external Samsung Odyssey G5 2560×1440@165 w/ builtin disabled; also installs `wdisplays`).
- `nh` — configured with `flake = "/home/${config.home.username}/.dotfiles"`, keeping last 5 generations.

`app/`: `ghostty` (CaskaydiaCove 17, no decoration, fish integration), `vesktop` (Discord, tray), `mpv`, `anki` (review-heatmap ice, image-occlusion), `qbittorrent`, `zathura` (PDF/epub, hashtag recolor, half-page scroll), `zen` — default browser w/ hard privacy policies, forced addons (uBlock, Bitwarden, ClearURLs), `betterfox`, 2 containers (Personal/Study), 2 spaces (Daily compact).

`desktop/`:
- `niri` (+ `desktop.shell.noctalia`) — sources `config/niri`→`~/.config/niri`, `xwayland-satellite`, session vars (`GDK_BACKEND=wayland`, `MOZ_ENABLE_WAYLAND=1`, `NIXOS_OZONE_WL=1`, `QT_QPA_PLATFORMTHEME=gtk3`).
- `shell/noctalia` — via `inputs.noctalia.homeModules.default`; full Noctalia shell: top bar opacity 0.9 w/ start workspaces + end tray/system widgets, bottom auto-hide dock (10 pinned apps), control center, backdrop, `assets/wallpapers/3.png` default, Catppuccin + Oxocarbon theme, location HCMC.

## NixOS Modules

`modules/nixos/default.nix` imports `./program ./service`. `modules.nixos.program.*`:
- `fcitx5` — via `inputs.fcitx5-lotus.nixosModules.fcitx5-lotus`; i18n.inputMethod fcitx5 + `services.fcitx5-lotus` for user `tai`.
- `steam` — overlay flags (`--no-cef-sandbox`, `-cef-disable-gpu-compositing`), `gamescopeSession`, gamemode, `ntfs3` fstab.
- `waydroid` — `virtualisation.waydroid` with nftables.
- `localsend` — `programs.localsend` + `openFirewall` option (default true).

`modules.nixos.service.*`:
- `keyd` — capslock ↔ escape globally.
- `sddm` — wayland (kwin compositor), window `banana-cursor` 28.

## Scripts

- `note` (`scripts/note.sh`) — git-backed notes in `~/Documents/notes`; `note [name]`/`note new` open daily/named `.md` in nvim, `note folder` → `Snacks.picker.files`, `note clone <url>`/`note pull`/`note push`. Flake runtime inputs: git, neovim, coreutils.
- `rcc` (`scripts/rcc.sh`) — `g++ -std=c++17 -O2 -Wall -Wextra file.cpp -o file && ./file && rm file`, multiple `.cpp` args, ignores non-.cpp.

## Conventions

- Home-manager modules: `options.modules.home.programs.<name>.enable = lib.mkEnableOption ...` → `config = lib.mkIf cfg.enable { ... }`; registered via `modules/home-manager/default.nix`. NixOS modules use `modules.nixos.*`.
- Hosts enable modules declaratively (e.g. `modules.home.programs.fish.enable = true;` in `hosts/*/home.nix`).
- Username `tai`, home `/home/tai`, state version `26.05`.
- Theme: Catppuccin Mocha (accent blue) — home level both hosts, system level only `asus-tuf`.
- Format Nix with nixfmt; keep modules small and single-purpose.