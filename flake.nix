{
  description = "My NixOS dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    fcitx5-lotus = {
      url = "github:LotusInputMethod/fcitx5-lotus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        note = pkgs.writeShellApplication {
          name = "note";
          runtimeInputs = [
            pkgs.git
            pkgs.neovim
            pkgs.coreutils
          ];
          text = builtins.readFile ./scripts/note.sh;
        };
        rcc = pkgs.writeShellApplication {
          name = "rcc";
          runtimeInputs = [
            pkgs.gcc
          ];
          text = builtins.readFile ./scripts/rcc.sh;
        };
      };
      nixosConfigurations = {
        acer-aspire = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/acer-aspire/configuration.nix
            home-manager.nixosModules.default
          ];
        };
        asus-tuf = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/asus-tuf/configuration.nix
            home-manager.nixosModules.default
            nixos-hardware.nixosModules.asus-fa506nc
          ];
        };
      };
    };
}
