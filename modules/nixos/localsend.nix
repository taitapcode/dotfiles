{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.localsend;
in
{
  options.modules.nixos.localsend = {
    enable = lib.mkEnableOption "Enable LocalSend";
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Open firewall port for receiving files";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.localsend = {
      enable = true;
      openFirewall = cfg.openFirewall;
    };
  };
}
