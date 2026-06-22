{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.git;
in
{
  options.modules.home.git.enable = lib.mkEnableOption "Enable Git configuration";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      
      settings = {
        user = {
          name = "taitapcode"; 
          email = "hoangductai2007@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
}
