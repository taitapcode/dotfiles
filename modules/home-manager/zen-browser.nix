{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.modules.home.zen-browser.enable = lib.mkEnableOption "Enable Zen Browser Configuration";

  config = lib.mkIf config.modules.home.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
    };
  };
}
