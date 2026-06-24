{ config, lib, ... }:
let
  cfg = config.modules.home.app.ghostty;
in
{
  options.modules.home.app.ghostty.enable = lib.mkEnableOption "Enable Ghostty configuration";

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
