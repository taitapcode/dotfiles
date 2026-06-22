{ config, lib, pkgs, ... }:
{
  options.neovim.enable = lib.mkEnableOption "Enable Neovim configuration";

  config = lib.mkIf config.neovim.enable  {
    programs.neovim = {
      enable = true;
      
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
