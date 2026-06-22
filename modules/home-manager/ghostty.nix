{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.ghostty;
in
{
  options.modules.home.ghostty.enable = lib.mkEnableOption "Enable Ghostty terminal configuration";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      installVimSyntax = true;

      settings = {
        theme = "Catppuccin Mocha";
        font-family = "CaskaydiaCove Nerd Font";
        font-size = 18;
        window-decoration = false;
      };
    };
  };
}
