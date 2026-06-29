{ config, lib, ... }:
let
  cfg = config.modules.home.app.vesktop;
in
{
  options.modules.home.app.vesktop.enable = lib.mkEnableOption "Enable Vesktop configuration";

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;

      settings = {
        discordBranch = "stable";
        tray = true;
      };
    };
  };
}
