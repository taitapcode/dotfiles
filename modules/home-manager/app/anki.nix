{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.home.app.anki;
in
{
  options.modules.home.app.anki.enable = lib.mkEnableOption "Enable Anki";

  config = lib.mkIf cfg.enable {
    home.packages = [ (pkgs.anki.withAddons (with pkgs.ankiAddons; [ review-heatmap ])) ];
  };
}
