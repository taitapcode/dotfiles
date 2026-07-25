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
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        banana-cursor
      ];

      settings = {
        Theme = {
          CursorTheme = "Banana";
          CursorSize = 24;
        };
      };
    };
  };
}
