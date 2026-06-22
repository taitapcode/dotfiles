{ config, lib, pkgs, ... }:
let
  cfg = config.modules.nixos.keyd;
in
{
  options.modules.nixos.keyd.enable = lib.mkEnableOption "Enable SDDM Display Manager configuration";

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          capslock = "esc";
          escape = "capslock";
        };
      };
    };
  };
}

