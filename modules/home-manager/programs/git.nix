{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.home.programs.git;
in
{
  options.modules.home.programs.git.enable = lib.mkEnableOption "Enable Git configuration";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "taitapcode";
          email = "hoangductai2007@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "https";
      };
    };

    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          showIcons = true;
        };
      };
    };
  };
}
