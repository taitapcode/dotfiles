{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.steam;
in
{
  options.modules.nixos.steam.enable = lib.mkEnableOption "Enable Steam support";

  config = lib.mkIf cfg.enable {
    boot.supportedFilesystems = [ "ntfs3" ];

    nixpkgs.overlays = [
      (final: prev: {
        steam = prev.steam.override {
          extraArgs = "--no-cef-sandbox -cef-disable-gpu-compositing";
        };
      })
    ];

    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;

      gamemode.enable = true;
    };
  };
}
