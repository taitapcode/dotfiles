{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.neovim;
in
{
  options.modules.home.neovim.enable = lib.mkEnableOption "Enable Neovim configuration";

  config = lib.mkIf cfg.enable  {
    home.packages = [ pkgs.wl-clipboard ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        set tabstop=2
        set shiftwidth=2
        set expandtab
        set number
        set relativenumber
        set clipboard=unnamedplus
      '';
    };
  };
}
