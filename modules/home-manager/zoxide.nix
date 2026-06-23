{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.home.zoxide;
in
{
  options.modules.home.zoxide.enable = lib.mkEnableOption "Enable Zoxide configuration";

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
