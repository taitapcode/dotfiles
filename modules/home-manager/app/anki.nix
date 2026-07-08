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
    home.packages = [
      (pkgs.anki.withAddons (
        with pkgs.ankiAddons;
        [
          (review-heatmap.withConfig {
            config = {
              color_theme = "ice";
              display_mode = "continuous";
              calendar_start_day = 1;
              exclude_manual_reschedules = true;
            };
          })
          advanced-browser
          image-occlusion-enhanced
        ]
      ))
    ];
  };
}
