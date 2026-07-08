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

    home.sessionVariables = {
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
    };

    modules.home.desktop.shell.noctalia.enable = true;

    xdg.configFile."niri".source = self + "/config/niri";
  };
}
