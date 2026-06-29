{ config, lib, ... }:
let
  cfg = config.modules.home.programs.bun;
in
{
  options.modules.home.programs.bun.enable = lib.mkEnableOption "Enable bun support";

  config = lib.mkIf cfg.enable {
    programs.bun.enable = true;
  };
}
