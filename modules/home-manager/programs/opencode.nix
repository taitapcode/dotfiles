{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.home.programs.opencode;
in
{
  options.modules.home.programs.opencode.enable = lib.mkEnableOption "Enable Opencode configuration";

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;
      tui = {
        theme = "catppuccin";
      };
    };
  };
}
