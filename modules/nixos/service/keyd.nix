{ config, lib, ... }:
let
  cfg = config.modules.nixos.service.keyd;
in
{
  options.modules.nixos.service.keyd.enable = lib.mkEnableOption "Enable Keyd configuration";

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
