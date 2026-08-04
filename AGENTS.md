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

The repo follows a fixed top-level layout; each directory holds **many** files of the same kind, so do not rely on a fixed file list — discover actual contents with glob/file search before touching anything.

```
.dotfiles/
├── flake.nix          # entrypoint
├── assets/            # static resources (images, wallpapers, avatars, screenshots) — any number of files
├── config/            # raw dotfiles mirroring ~/.config structure; sourced by modules via `self + "/config/<app>/..."` (home.file for each top-level app dir). Anything here maps 1:1 onto a config app/subdir.
├── hosts/<host>/      # per-machine NixOS config; each host = one dir, enabled `<host>` attr in flake
├── modules/
│   ├── home-manager/  # one file per module under app/ programs/ desktop/ (see below)
│   └── nixos/         # one file per module under program/ service/
└── scripts/           # one *.sh helper per flake package/lazy-exec; each is wrapped via writeShellApplication
```

Conventions when adding files:

- **`config/`**: add the whole app dir as-is (mirror of `~/.config`); wire it into the matching home-manager module. No per-file listing needed.
- **`modules/`**: one module per file, named `<name>.nix`, placed under the category dir (`programs/`, `app/`, `desktop/` for home; `program/`, `service/` for nixos). Groups of related modules may live in a subdir with their own `default.nix` (e.g. `desktop/shell/`).
- **`hosts/`**: add a new host by creating `<name>/configuration.nix` + `<name>/home.nix` and exporting a `nixosConfigurations.<name>` in `flake.nix`.
- **`scripts/`**: add a new `scripts/<name>.sh` and expose it as `packages.${system}.<name>` in `flake.nix`.
- **`assets/`**: drop files here; reference by `self + "/assets/<file>"`.

## Hosts

Both hosts share the same `home.nix` (catppuccin mocha/blue, xdg.mimeApps defaults, all app+program modules enabled); differences are in `configuration.nix`.

Common to both: GRUB+EFI, TZ `Asia/Ho_Chi_Minh`, hostname `nixos`, user `tai` (shell fish), pipewire+pulse, printing (cups), bluetooth, `libinput`, `upower`, `xdg-desktop-portal-gnome`, NetworkManager, `nix-command`+`flakes`, fonts (noto cjk, ubuntu, caskaydia-cove + jetbrains-mono nerdfonts), state version `26.05`. Modules enabled on both: `modules.nixos.service.{keyd,sddm}`, `modules.nixos.program.{fcitx5,waydroid,steam}`.

- **asus-tuf** (FA506NC) — **primary/actively used machine**; build/test with `nh os switch` here by default. Imports nixos-hardware `asus-fa506nc`; NVIDIA (modesetting, powerManagement, nvidiaPersistenced), `acpi_backlight=native`, `services.asusd` (charge limit 80%, profile linked to power), `/mnt/Storage` NTFS, `modules.nixos.program.localsend`; also enables system-level catppuccin module (mocha+blue, autoEnable).
- **acer-aspire** (Intel): **no longer used** — kept for reference/backup only; do not rely on it. GRUB+EFI, `power-profiles-daemon`, swap, NTFS `/mnt/games`, Intel microcode, `kvm-intel`.

## Home-Manager Modules

`modules/home-manager/default.nix` imports `./app ./programs ./desktop`. Option namespace: `modules.home.*`. One module per file under the category dirs; hosts enable them declaratively in `hosts/*/home.nix`. The module inventory is **not** enumerated here — discover it by globbing `modules/home-manager/*/*.nix` (e.g. `programs/*.nix`, `app/*.nix`, `desktop/**/*.nix`).

Pattern: `options.modules.home.programs.<name>.enable = lib.mkEnableOption ...` → `config = lib.mkIf cfg.enable { ... }`. Modules that configure an app keep its dotfiles in `config/<app>/` and source them via `self + "/config/<app>/..."`.

Stable facts worth knowing (don't treat as exhaustive):
- `programs/git` holds the git identity: user `taitapcode` / hoangductai2007@gmail.com.
- Auto-chains (see Flake section): `programs/fish` also enables `fzf`, `zoxide`, `yazi`; `desktop/niri` also enables `desktop/shell/noctalia`.

## NixOS Modules

`modules/nixos/default.nix` imports `./program ./service`. Option namespace: `modules.nixos.*`. One module per file; discover by globbing `modules/nixos/*/*.nix`.

Pattern: `options.modules.nixos.<category>.<name>.enable = lib.mkEnableOption ...` → `config = lib.mkIf cfg.enable { ... }`.

## Scripts

Each helper is `scripts/<name>.sh`, wrapped as `packages.${system}.<name>` in `flake.nix` via `writeShellApplication`. Discover by globbing `scripts/*.sh`; details live inside each script (usage/help in the header).

## Conventions

- Hosts enable modules declaratively (e.g. `modules.home.programs.fish.enable = true;` in `hosts/*/home.nix`).
- Username `tai`, home `/home/tai`, state version `26.05`.
- Theme: Catppuccin Mocha (accent blue) — home level both hosts, system level only `asus-tuf`.
- Format Nix with nixfmt; keep modules small and single-purpose.
