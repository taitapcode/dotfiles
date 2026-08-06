{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.program.waydroid;
in
{
  options.modules.nixos.program.waydroid.enable = lib.mkEnableOption "Enable waydroid";

  config = lib.mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
    virtualisation.waydroid.package = pkgs.waydroid-nftables;
  };
}
