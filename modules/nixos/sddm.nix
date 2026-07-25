{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.sddm;
in
{
  options.modules.nixos.sddm.enable = lib.mkEnableOption "Enable SDDM Display Manager configuration";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      banana-cursor
    ];

    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
      settings = {
        Theme = {
          CursorTheme = "Banana";
          CursorSize = 28;
        };
      };
    };
  };
}
