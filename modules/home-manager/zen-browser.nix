{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.home.zen-browser;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.modules.home.zen-browser.enable = lib.mkEnableOption "Enable Zen Browser Configuration";

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
    };
  };
}
