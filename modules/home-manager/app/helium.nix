{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.modules.home.app.helium;
in
{
  imports = [ inputs.helium-flake.homeModules.default ];

  options.modules.home.app.helium.enable = lib.mkEnableOption "Enable helium browser";

  config = lib.mkIf cfg.enable {
    programs.helium = {
      enable = true;

      flags = [
        "--enable-features=TouchpadOverscrollHistoryNavigation"
        "--ozone-platform-hint=auto"
        "--no-default-browser-check"
      ];

      policies = {
        "BrowserSignin" = 0; # Disable browser signin
        "PasswordManagerEnabled" = false; # Disable password manager
      };
    };

  };
}
