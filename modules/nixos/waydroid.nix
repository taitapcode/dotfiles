{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.waydroid;
in
{
  options.modules.nixos.waydroid.enable = lib.mkEnableOption "Enable waydroid support";

  config = lib.mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
    virtualisation.waydroid.package = pkgs.waydroid-nftables;
  };
}
