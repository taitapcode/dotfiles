{ config, lib, ... }:
let
  cfg = config.modules.home.programs.fzf;
in
{
  options.modules.home.programs.fzf.enable = lib.mkEnableOption "Enable FZF configuration";

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      defaultCommand = "fd . -H -E .git -E node_modules";

      colors = {
        "bg+" = "#313244";
        "bg" = "#1e1e2e";
        "spinner" = "#f5e0dc";
        "hl" = "#f38ba8";
        "fg" = "#cdd6f4";
        "header" = "#f38ba8";
        "info" = "#cba6f7";
        "pointer" = "#f5e0dc";
        "marker" = "#f5e0dc";
        "fg+" = "#cdd6f4";
        "prompt" = "#cba6f7";
        "hl+" = "#f38ba8";
      };

      fileWidgetOptions = [
        "--preview 'if test -d {}; eza --tree --color=always {} | head -200; else; bat --style=numbers --color=always --line-range :500 {}; end'"
      ];

      historyWidgetOptions = [
        "--preview 'echo {}'"
        "--preview-window down:3:hidden:wrap"
        "--bind 'ctrl-/:toggle-preview'"
        "--color 'header:italic'"
        "--header 'Press CTRL-/ to toggle full command view'"
      ];

    };
  };
}
