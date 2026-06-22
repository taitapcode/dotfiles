{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.yazi;
in
{
  options.modules.home.yazi.enable = lib.mkEnableOption "Enable Yazi file manager configuration";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;

      settings = {
        manager = {
          show_hidden = true;
          sort_by = "name";
          sort_sensitive = false;
          sort_dir_first = true;
        };
      };
    };
  };
}
