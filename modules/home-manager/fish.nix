{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.fish;
in
{
  options.modules.home.fish.enable = lib.mkEnableOption "Enable Fish shell configuration";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting ""
      '';

      shellAliases = {
        cat = "bat";
        ls = "eza --icons";
	v = "nvim";
	lg = "lazygit";
      };
    };
  };
}
