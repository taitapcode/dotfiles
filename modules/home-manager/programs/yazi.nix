{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.home.programs.yazi;
in
{
  options.modules.home.programs.yazi.enable =
    lib.mkEnableOption "Enable Yazi file manager configuration";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;

      settings = {
        mgr = {
          show_hidden = true;
          sort_dir_first = true;
        };
        preview.image_quality = 90;
        plugin.prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";

          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];

      };

      plugins = with pkgs.yaziPlugins; {
        full-border = full-border;
        git = git;
        smart-enter = smart-enter;
        smart-paste = smart-paste;
        no-status = no-status;
      };

      initLua = ''
        require("full-border"):setup()
        require("git"):setup({ order = 1500 })
        require("smart-enter"):setup { open_multi = true }
        require("no-status"):setup()
      '';

      keymap = {
        mgr.prepend_keymap = [
          {
            on = [ "l" ];
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = [ "p" ];
            run = "plugin smart-paste";
            desc = "Paste into the hovered directory or CWD";
          }
          {
            on = [ "d" ];
            run = "remove --permanently";
            desc = "Remove file";
          }
        ];

        input.prepend_keymap = [
          {
            on = [ "<Esc>" ];
            run = "close";
            desc = "Cancel input";
          }
        ];
      };
    };
  };
}
