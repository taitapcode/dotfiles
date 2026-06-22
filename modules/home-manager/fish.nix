{ config, lib, pkgs, ... }:

{
  options.fish.enable = lib.mkEnableOption "Enable Fish shell configuration";

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;

      enableBehavior = true; 

      interactiveShellInit = ''
        set -g fish_greeting ""
      '';

      shellAliases = {
        cat = "bat";
        ls = "eza --icons";
	v = "nvim";
      };
    };
  };
}
