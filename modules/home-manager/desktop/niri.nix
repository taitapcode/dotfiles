{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.home.desktop.niri;
in
{
  imports = [
    ./shell
  ];

  options.modules.home.desktop.niri.enable = lib.mkEnableOption "Enable Niri configuration";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      xwayland-satellite
    ];

    modules.home.desktop.shell.noctalia.enable = true;

    xdg.configFile."niri".source = self + "/config/niri";
  };
}
