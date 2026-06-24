{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.home.program.git;
in
{
  options.modules.home.program.git.enable = lib.mkEnableOption "Enable Git configuration";

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
          theme = {
            activeBorderColor = [
              "#89b4fa"
              "bold"
            ];
            inactiveBorderColor = [ "#a6adc8" ];
            optionsTextColor = [ "#89b4fa" ];
            selectedLineBgColor = [ "#313244" ];
            cherryPickedCommitBgColor = [ "#45475a" ];
            cherryPickedCommitFgColor = [ "#89b4fa" ];
            unstagedChangesColor = [ "#f38ba8" ];
            defaultFgColor = [ "#cdd6f4" ];
            searchingActiveBorderColor = [ "#f9e2af" ];
          };
          authorColors = {
            "*" = "#b4befe";
          };
        };
      };
    };
  };
}
