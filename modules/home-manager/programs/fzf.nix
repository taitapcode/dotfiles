{ config, lib, ... }:
let
  cfg = config.modules.home.programs.fzf;
in
{
  options.modules.home.programs.fzf.enable = lib.mkEnableOption "Enable FZF configuration";

  config = lib.mkIf cfg.enable {
    programs = {
      bat.enable = true;
      eza.enable = true;
      ripgrep.enable = true;
      fd.enable = true;

      fzf = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        fileWidget.options = [
          "--preview 'if test -d {}; eza --tree --color=always {} | head -200; else; bat --style=numbers --color=always --line-range :500 {}; end'"
        ];

        historyWidget.options = [
          "--preview 'echo {}'"
          "--preview-window down:3:hidden:wrap"
          "--bind 'ctrl-/:toggle-preview'"
          "--color 'header:italic'"
          "--header 'Press CTRL-/ to toggle full command view'"
        ];

      };

    };
  };
}
