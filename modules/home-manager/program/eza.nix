{ config, lib, ... }:
let
  cfg = config.modules.home.programs.eza;
in
{
  options.modules.home.programs.eza.enable = lib.mkEnableOption "Enable Eza configuration";

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      git = true;
      icons = "always";
      extraOptions = [
        "--group-directories-first"
      ];
    };
  };
}
