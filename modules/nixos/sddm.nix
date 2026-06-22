{ config, lib, pkgs, ... }:
let
  cfg = config.modules.nixos.sddm;
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };
in
{
  options.modules.nixos.sddm.enable = lib.mkEnableOption "Enable SDDM Display Manager configuration";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      banana-cursor
      sddm-astronaut
    ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

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
