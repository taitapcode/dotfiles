{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.modules.home.noctalia;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.modules.home.noctalia.enable = lib.mkEnableOption "Enable Noctalia shell configuration";

  config = lib.mkIf cfg.enable {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enable = true;
          directory = "${inputs.self}/wallpapers";
          default.path = "${inputs.self}/wallpapers/wallhaven-6lw5ll.jpg";
        };
      };
    };
  };
}
