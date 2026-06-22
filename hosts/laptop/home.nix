{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/niri.nix
    ../../modules/home-manager/zen-browser.nix
    ../../modules/home-manager/fish.nix
  ];

  home.username = "tai";
  home.homeDirectory = "/home/tai";
  home.stateVersion = "26.05";

  niri.enable = true;
  zen-browser.enable = true;
  fish.enable = true;
}
