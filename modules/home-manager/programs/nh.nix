{ config, lib, ... }:
let
  cfg = config.modules.home.programs.nh;
in
{
  options.modules.home.programs.nh.enable = lib.mkEnableOption "Enable nix helper configuration";

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "/home/${config.home.username}/.dotfiles";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5";
      };

    };
  };
}
