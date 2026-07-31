{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.home.programs.kanshi;
in
{
  options.modules.home.programs.kanshi.enable = lib.mkEnableOption "Enable kanshi";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wdisplays ];

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
                mode = "1920x1080@144Hz";
                scale = 1.0;
                position = "0,0";
              }
            ];
          };
        }
        {
          profile = {
            name = "Asus-TUF-Laptop-DoMinh-Monitor";
            outputs = [
              {
                criteria = "Samsung Electric Company Odyssey G5 HNBY300070";
                status = "enable";
                mode = "2560x1440@144Hz";
                scale = 1.0;
                position = "0,0";
              }

              {
                criteria = "Chimei Innolux Corporation 0x1521 Unknown";
                status = "enable";
                mode = "1920x1080@144Hz";
                scale = 1.0;
                position = "2560,0";
              }
            ];
          };
        }
      ];
    };
  };
}
