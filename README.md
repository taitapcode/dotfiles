# nixos-btw

NixOS dotfiles for my laptop — a fully declarative, reproducible setup powered by the [Nix](https://nixos.org/) package manager.

## Usage

### Apply the config

```bash
# NixOS rebuild (after cloning on a new NixOS system)
sudo nixos-rebuild switch --flake .#laptop

# Or with nh (if installed)
nh os switch .
```

### Toggle modules

Each component can be enabled/disabled in `hosts/laptop/configuration.nix`:

```nix
modules.nixos = {
  sddm.enable = true;
  keyd.enable = true;
  fcitx5.enable = true;
};
```

And in `hosts/laptop/home.nix`:

```nix
modules.home = {
  shell.fish.enable = true;
  program.neovim.enable = true;
  app.zen-browser.enable = true;
  desktop.niri.enable = true;
};
```

## Screenshots

> TODO

## License

MIT
