{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.neovim;
in
{
  options.modules.home.neovim.enable = lib.mkEnableOption "Enable Neovim configuration";

  config = lib.mkIf cfg.enable  {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
