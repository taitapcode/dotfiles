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

    fileSystems."/mnt/games" = {
      device = "/dev/disk/by-uuid/88B408DEB408D09C";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=100"
        "rw"
        "exec"
        "nofail"
        "force"
      ];
    };

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
