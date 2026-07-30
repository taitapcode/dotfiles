{ config, lib, ... }:

let
  cfg = config.modules.home.programs.kanshi;
in
{
  options.modules.home.programs.kanshi.enable = lib.mkEnableOption "Enable kanshi";

  config = lib.mkIf cfg.enable {
    services.kanshi = {
      enable = true;
      settings = [
        {
          profile = {
            name = "Asus-TUF-Laptop";
            outputs = [
              {
                criteria = "Chimei Innolux Corporation 0x1521 Unknown";
                status = "enable";
                mode = "1920x1080@144.003Hz";
                scale = 1.0;
                position = "0,0";
              }
            ];
          };
        }
      ];
    };
  };
}
