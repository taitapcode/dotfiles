{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.home.app.qbittorrent;
in
{
  options.modules.home.app.qbittorrent.enable = lib.mkEnableOption "Enable qbittorrent";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ qbittorrent ];
  };
}
