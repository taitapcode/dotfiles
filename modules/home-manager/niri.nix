{ config, pkgs, lib,inputs, ... }: {
  imports = [
    inputs.niri.homeModules.niri
  ];

  options.niri.enable = lib.mkEnableOption "Enable Niri configuration";

  config = lib.mkIf options.enable {
    programs.niri = {
      enable = true;

      settings = {
        input = {
          keyboard.numlock = true;
          touchpad = {
            tap = true;
            natural-scroll = true;
          };
          focus-follows-mouse.max-scroll-amount = "0%";
        };

        layout = {
          gaps = 7;
          center-focused-column = "never";
          
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];
          
          default-column-width = { proportion = 0.75; };
          
          focus-ring = {
            width = 2;
            active-color = "#7fc8ff";
            inactive-color = "#505050";
          };
          
          border.off = true;
          
          shadow = {
            softness = 30;
            spread = 5;
            offset = { x = 0; y = 5; };
            color = "#0007";
          };
        };

        # spawn-at-startup = [
        #   { command = [ "fcitx5" "-d" ]; }
        # ];

        environment = {
          QT_QPA_PLATFORMTHEME = "gtk3";
          XCURSOR_THEME = "Banana";
          XCURSOR_SIZE = "45";
        };

        # xwayland-satellite.path = "xwayland-satellite";
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        # --- Window & Layer Rules ---
        window-rules = [
          {
            geometry-corner-radius = 5;
            clip-to-geometry = true;
            popups = {
              geometry-corner-radius = 15;
              opacity = 0.8;
              background-effect.blur = true;
            };
          }
          {
            matches = [ { app-id = "com.mitchellh.ghostty"; } ];
            opacity = 0.9;
            background-effect = { blur = true; xray = false; };
          }
          {
            matches = [ { app-id = "kitty"; } ];
            opacity = 0.9;
            background-effect = { blur = true; xray = false; };
          }
          {
            open-maximized = true;
          }
        ];

        layer-rules = [
          {
            matches = [ { namespace = "dms:*"; } ];
            background-effect.xray = false;
          }
        ];

        # --- Keybindings ---
        binds = with config.lib.niri.actions; {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          "Mod+Return" = { action = spawn "ghostty"; hotkey-overlay-title = "Open a terminal"; };
          "Mod+B" = { action = spawn "zen-browser"; hotkey-overlay-title = "Run a browser"; };
          "Mod+E" = { action = spawn "nautilus"; hotkey-overlay-title = "Run a file explorer"; };

          "Mod+D" = { action = spawn "dms" "ipc" "call" "spotlight" "toggle"; hotkey-overlay-title = "Run launcher"; };
          "Mod+S" = { action = spawn "dms" "ipc" "call" "control-center" "toggle"; hotkey-overlay-title = "Open control center"; };
          "Mod+Alt+L" = { action = spawn "dms" "ipc" "call" "lock" "lock"; hotkey-overlay-title = "Lock the Screen: swaylock"; };
          "Mod+P" = { action = spawn "dms" "ipc" "call" "powermenu" "open"; hotkey-overlay-title = "Open power menu"; };

          "Super+Alt+S" = { action = spawn-sh "pkill orca || exec orca"; allow-when-locked = true; };

          "XF86AudioRaiseVolume" = { action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.5"; allow-when-locked = true; };
          "XF86AudioLowerVolume" = { action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; allow-when-locked = true; };
          "XF86AudioMute" = { action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; allow-when-locked = true; };
          "XF86AudioMicMute" = { action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; allow-when-locked = true; };

          "XF86AudioPlay" = { action = spawn-sh "playerctl play-pause"; allow-when-locked = true; };
          "XF86AudioStop" = { action = spawn-sh "playerctl stop"; allow-when-locked = true; };
          "XF86AudioPrev" = { action = spawn-sh "playerctl previous"; allow-when-locked = true; };
          "XF86AudioNext" = { action = spawn-sh "playerctl next"; allow-when-locked = true; };

          "XF86MonBrightnessUp" = { action = spawn "brightnessctl" "--class=backlight" "set" "+10%"; allow-when-locked = true; };
          "XF86MonBrightnessDown" = { action = spawn "brightnessctl" "--class=backlight" "set" "10%-"; allow-when-locked = true; };

          "Mod+Tab" = { action = toggle-overview; repeat = false; };
          "Mod+C" = { action = close-window; repeat = false; };

          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;

          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+L".action = move-column-right;

          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;
          "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
          "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;

          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;

          "Mod+Shift+Left".action = focus-monitor-left;
          "Mod+Shift+Down".action = focus-monitor-down;
          "Mod+Shift+Up".action = focus-monitor-up;
          "Mod+Shift+Right".action = focus-monitor-right;
          "Mod+Shift+H".action = focus-monitor-left;
          "Mod+Shift+J".action = focus-monitor-down;
          "Mod+Shift+K".action = focus-monitor-up;
          "Mod+Shift+L".action = focus-monitor-right;

          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-column-to-workspace-down;
          "Mod+Ctrl+I".action = move-column-to-workspace-up;

          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;
          "Mod+Shift+U".action = move-workspace-down;
          "Mod+Shift+I".action = move-workspace-up;

          "Mod+Shift+WheelScrollDown" = { action = focus-workspace-down; cooldown-ms = 150; };
          "Mod+Shift+WheelScrollUp" = { action = focus-workspace-up; cooldown-ms = 150; };
          "Mod+Ctrl+WheelScrollDown" = { action = move-column-to-workspace-down; cooldown-ms = 150; };
          "Mod+Ctrl+WheelScrollUp" = { action = move-column-to-workspace-up; cooldown-ms = 150; };

          "Mod+WheelScrollDown".action = focus-column-right;
          "Mod+WheelScrollUp".action = focus-column-left;
          "Mod+Ctrl+WheelScrollRight".action = move-column-right;
          "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

          "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;

          "Mod+Ctrl+1".action = move-column-to-workspace 1;
          "Mod+Ctrl+2".action = move-column-to-workspace 2;
          "Mod+Ctrl+3".action = move-column-to-workspace 3;
          "Mod+Ctrl+4".action = move-column-to-workspace 4;
          "Mod+Ctrl+5".action = move-column-to-workspace 5;
          "Mod+Ctrl+6".action = move-column-to-workspace 6;
          "Mod+Ctrl+7".action = move-column-to-workspace 7;
          "Mod+Ctrl+8".action = move-column-to-workspace 8;
          "Mod+Ctrl+9".action = move-column-to-workspace 9;

          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+F".action = expand-column-to-available-width;
          "Mod+Shift+C".action = center-column;
          "Mod+Ctrl+C".action = center-visible-columns;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
          "Mod+W".action = toggle-column-tabbed-display;

          "Mod+Shift+S" = { action = screenshot; show-pointer = false; };
          "Mod+Shift+Ctrl+S" = { action = screenshot-screen; show-pointer = false; };
          "Mod+Shift+Alt+S" = { action = screenshot-window; show-pointer = false; };

          "Mod+Escape" = { action = toggle-keyboard-shortcuts-inhibit; allow-inhibiting = false; };
          "Mod+Shift+E".action = quit;
          "Ctrl+Alt+Delete".action = quit;
          "Mod+Shift+P".action = power-off-monitors;

          "Mod+Delete".action = spawn "systemctl" "poweroff";
          "Mod+Insert".action = spawn "systemctl" "reboot";
        };
      };
    };
  };
}
