{ config, lib, ... }:
let
  cfg = config.modules.home.programs.mangohud;
in
{
  options.modules.home.programs.mangohud.enable = lib.mkEnableOption "Enable MangoHud configuration";

  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
    };
  };
}
