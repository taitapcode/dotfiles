{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.home.programs.zoxide;
in
{
  options.modules.home.programs.zoxide.enable = lib.mkEnableOption "Enable Zoxide configuration";

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
