{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/niri.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/zen-browser.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/nvim.nix
  ];

  home.username = "tai";
  home.homeDirectory = "/home/tai";
  home.stateVersion = "26.05";

  modules.home = {
    niri.enable = true;
    git.enable = true;
    zen-browser.enable = true;
    fish.enable = true;
    neovim.enable = true;
  };
}
