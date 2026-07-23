{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.home.programs.tmux;
in
{
  options.modules.home.programs.tmux.enable = lib.mkEnableOption "Enable Tmux configuration";

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      escapeTime = 0;
      prefix = "C-s";
      baseIndex = 1;
      keyMode = "vi";
      mouse = true;
      disableConfirmationPrompt = true;
      newSession = true;
      sensibleOnTop = true;
      focusEvents = true;

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        vim-tmux-navigator
        pain-control
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor 'mocha'
            set -g @catppuccin_status_fill "all"
            set -g @catppuccin_directory_text "#{pane_current_path}"
            set -g @catppuccin_application_icon " "
            set -g @catppuccin_session_icon " "
          '';
        }
      ];

      extraConfig = ''
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"
        set-option -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{}"
        set -ag status-right "#{}"

        bind -n M-H previous-window
        bind -n M-L next-window

        bind n split-window -h -l 30% "fish -c 'note'"
        bind f split-window -h -l 30% "fish -c 'note folder'"
      '';
    };
  };
}
