{
  config,
  lib,
  self,
  ...
}:

let
  cfg = config.modules.home.programs.fcitx5;
in
{
  options.modules.home.programs.fcitx5.enable = lib.mkEnableOption "Enable Fcitx5 configuration";

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      GTK_IM_MODULE = "fcitx5";
      QT_IM_MODULE = "fcitx5";
      XMODIFIERS = "@im=fcitx5";
    };

    xdg.configFile."fcitx5".source = self + "/fcitx5";
  };
}
