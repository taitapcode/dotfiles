{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.fcitx5;
in
{
  imports = [
    inputs.fcitx5-lotus.nixosModules.fcitx5-lotus
  ];

  options.modules.nixos.fcitx5.enable = lib.mkEnableOption "Enable Fcitx5 Lotus configuration";

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          qt6Packages.fcitx5-configtool
        ];
      };
    };

    services.fcitx5-lotus = {
      enable = true;
      users = [ "tai" ];
    };
  };
}
