{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.git;
in
{
  options.modules.home.git.enable = lib.mkEnableOption "Enable Git configuration";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      
      userName = "taitapcode"; 
      userEmail = "hoangductai2007@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
      
      delta.enable = true;
    };
  };
}
