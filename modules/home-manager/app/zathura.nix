{ config, lib, ... }:
let
  cfg = config.modules.home.app.zathura;
in
{
  options.modules.home.app.zathura.enable = lib.mkEnableOption "Enable Zathura configuration";

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
