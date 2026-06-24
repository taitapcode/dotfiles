{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.home.program.zoxide;
in
{
  options.modules.home.program.zoxide.enable = lib.mkEnableOption "Enable Zoxide configuration";

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
