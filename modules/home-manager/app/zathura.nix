{ config, lib, ... }:
let
  cfg = config.modules.home.app.zathura;
in
{
  options.modules.home.app.zathura.enable = lib.mkEnableOption "Enable zathura";

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;

      options = {
        guioptions = ""; # Clear GUI bars ("s" = statusbar, "v" = vertical scrollbar)
        selection-notification = false; # Stop selection copy from triggering the status line

        # Direct clipboard integration (saves you from manually running :copy)
        selection-clipboard = "clipboard";

        # Better scrolling behavior
        scroll-page-step = "0.5"; # Scroll half a page at a time with space/page-down
        scroll-full-step = "1.0";
        smooth-scroll = true; # Smoother page transitions

        # Search settings
        incremental-search = true; # Jump to matches as you type
        search-hadjust = true; # Auto-center search results horizontally

        # Default view mode on launch
        adjust-open = "best-fit"; # Options: "width" (fit-to-width) or "best-fit"
        pages-per-row = "1";
      };

      mappings = {
        # Single-key toggle for dark mode / invert colors
        "<Tab>" = "recolor";

        "<Esc>" = "clear";
        "Space" = "clear";
      };
    };
  };
}
