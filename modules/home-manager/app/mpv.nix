{ config, lib, ... }:
let
  cfg = config.modules.home.app.mpv;
in
{
  options.modules.home.app.mpv.enable = lib.mkEnableOption "Enable mpv";

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
