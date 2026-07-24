{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.sddm;
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
  };
in
{
  options.modules.nixos.sddm.enable = lib.mkEnableOption "Enable SDDM Display Manager configuration";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      banana-cursor
      sddm-astronaut
    ];

    services.xserver.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = false;

      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        banana-cursor
        kdePackages.qtmultimedia
      ];

      theme = "sddm-astronaut-theme";

      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
          CursorTheme = "Banana";
          CursorSize = 24;
        };
      };
    };
  };
}
