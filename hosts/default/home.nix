{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
in {
  home.username = "tai";
  home.homeDirectory = "/home/tai";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    brave

    nodejs_23
    gcc14
    rustc
    python314
    cargo

    unzip
    wget
    wl-clipboard-x11
    curl
    brightnessctl
    playerctl

    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/dotfiles/nvim/.config/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS-White";
    size = 40;
    hyprcursor = {
      enable = true;
      size = 40;
    };
    gtk.enable = true;
    x11.enable = true;
  };

  # Enable Network Manager Applet
  services.network-manager-applet.enable = true;

  # Gtk
  gtk = {
    enable = true;
    theme = {
      package = pkgs.juno-theme;
      name = "Juno";
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
    gtk4 = {
      extraConfig.gtk-cursor-blink = true;
    };
  };

  # Enable catppuccin theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
    nvim.enable = false;
  };

  # Wallpapers
  services.random-background = {
    enable = true;
    imageDirectory = "${homeDir}/.local/share/wallpapers";
    display = "center";
    interval = "30m";
  };

  # Hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$browser" = "brave";

    monitor= ",preferred,auto,1";

    general = {
      gaps_in = 5;
      gaps_out = 20;

      border_size = 2;

      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      resize_on_border = false;
      allow_tearing = false;

      layout = "dwindle";
    };

    decoration = {
      rounding = 3;

      active_opacity = 0.95;
      inactive_opacity = 0.9;

      shadow = {
        enabled = true;
        range = 10;
      };

      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        xray = false;
        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;
      bezier = "overshot,0.05,0.9,0.1,1.1";

      animation= [
        "windows,1,4,overshot,slide"
        "border,1,10,default"
        "fade,1,10,default"
        "workspaces,1,6,overshot,slide"
      ];
    };

    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
      preserve_split = true; # You probably want this
    };

    master.new_status = "master";
    cursor.enable_hyprcursor = true;

    input = {
      follow_mouse = 1;
      touchpad.natural_scroll = true;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;

      enable_swallow = true;
      swallow_regex = "^(kitty)$";
    };

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mod, Return, exec, $terminal"
      "$mod, C, killactive,"
      "$mod, M, exit,"
      "$mod, B, exec, $browser"
      "$mod, F, fullscreen"

      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, L, movewindow, r"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, J, movewindow, d"

      # Example special workspace (scratchpad)
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      )
      9)
    );

    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
    ];

    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };

  # Programs
  programs = {
    home-manager.enable = true;
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    gh.enable = true;
    lazygit.enable = true;

    kitty = {
      enable = true;
      settings = {
        font_family = "Caskaydia Cove NF";
        font_size = 18;
        wheel_scroll_multiplier = 5;
        tab_bar_min_tabs = 2;
        hide_window_decorations = true;
      };
    };

    neovim = {
      enable = true;
      vimAlias = true;
    };

    fish = {
      enable = true;
      shellAliases = {
        ".." = "z ..";
	      "..." = "z ../..";
	      cl = "clear";
        rf = "rm -rf";
        lg = "lazygit";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        fish_vi_key_bindings
      '';
      # plugins = [
      #   {
      #     name = "bang-bang";
      #     src = pkgs.fishPlugins.bang-bang;
      #   }
      # ];
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = "$directory$character";
        right_format = "$all";
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
          vimcmd_symbol = "[❯](bold green)";
          vimcmd_replace_one_symbol = "[❯](bold purple)";
          vimcmd_replace_symbol = "[❯](bold purple)";
          vimcmd_visual_symbol = "[❯](bold yellow)";
        };
        directory = {
          truncation_length = 1;
        };
      };
    };

    git = {
      enable = true;
      userEmail = "hoangductai2007@gmail.com";
      userName = "taitapcode";
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      tmux.enableShellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      extraOptions = [ "--icons" "--group-directories-first" ];
    };

    nh = {
      enable = true;
      flake = "${homeDir}/nixos-config";
      clean.enable = true;
    };

    tmux = {
      enable = true;
      prefix = "C-s";
      disableConfirmationPrompt = true;
      escapeTime = 0;
      mouse = true;
      keyMode = "vi";
      extraConfig = ''
        # Allow yazi preview images
        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        # Moving between windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # Kill windows and panes without confirm
        bind-key x kill-pane
        bind-key & kill-window
      '';
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.pain-control
        tmuxPlugins.sensible
        tmuxPlugins.yank
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
            set -g @catppuccin_window_status_style "rounded"
            set -g @catppuccin_status_fill "all"
            set -g @catppuccin_directory_text "#{pane_current_path}"
            set -g @catppuccin_application_icon " "
            set -g @catppuccin_session_icon " "
            set -g status-position top
          '';
        }
      ];
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          "layer" = "top";
          "position" = "top"; # Waybar position (top|bottom|left|right)
          "height" = 50; # Waybar height (to be removed for auto height)
          # "width" = 1280; # Waybar width
          "spacing" = 5; # Gaps between modules (4px)
          # Choose the order of the modules
          # "margin-left" =25;
          # "margin-right" =25;
          "margin-bottom" = -11;
          #"margin-top" =5;
          "modules-left" = ["hyprland/workspaces"  "hyprland/window"];
          "modules-right" = [
            "tray"
            "backlight"
            "pulseaudio"
            "battery"
            "memory"
            "disk"
            "cpu"
            "custom/notification"
            "clock"
          ];

          "custom/notification" = {
            "tooltip" = false;
            "format" = "{icon}";
            "format-icons" = {
              "notification" = "<span foreground='red'><sup></sup></span>";
              "none" = "";
              "dnd-notification" = "<span foreground='red'><sup></sup></span>";
              "dnd-none" = "";
              "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
              "inhibited-none" = "";
              "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
              "dnd-inhibited-none" = "";
            };
            "return-type" = "json";
            "exec-if" = "which swaync-client";
            "exec" = "swaync-client -swb";
            "on-click" = "swaync-client -t -sw";
            "on-click-right" = "swaync-client -d -sw";
            "escape" = true;
          };

          "disk" = {
            "format" = " {percentage_used}%";
            "tooltip" = true;
            "tooltip-format" = "{used} / {total}";
          };

          "hyprland/window" = {
            "max-length" = 90;
          };

          "hyprland/workspaces" = {
            "format" = "{icon}";
            "format-active" = " {icon} ";
            "on-click" = "activate";
          };

          "tray" = {
            "spacing" = 10;
          };
          "clock" = {
            "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            "interval" = 60;
            "format" = "{:%I:%M}";
            "max-length" = 25;
          };
          "cpu" = {
            "interval" = 1;
            "format" = "{icon0} {icon1} {icon2} {icon3}";
            "format-icons" = ["▁" "▂"  "▃"  "▄"  "▅"  "▆"  "▇"  "█"];
          };
          "memory" = {
            "interval" = 5;
            "format" = " {}%";
            "max-length" = 10;
          };
          "backlight" = {
            "format" = "{icon} {percent}%";
            "format-icons" = ["" ""  ""  ""  ""  ""  ""  ""  ""];
          };
          "battery" = {
            "format" = "{icon} {capacity}%";
            "format-icons" = {
              "charging" = ["󰢜" "󰂆"  "󰂇"  "󰂈"  "󰢝"  "󰂉"  "󰢞"  "󰂊"  "󰂋"  "󰂅"];
              "default" = ["󰁺" "󰁻"  "󰁼"  "󰁽"  "󰁾"  "󰁿"  "󰂀"  "󰂁"  "󰂂"  "󰁹"];
            };
            "interval" = 5;
            "states" = {
              "warning" = 20;
              "critical" = 10;
            };
            "tooltip" = false;
          };
          "battery#bat2" = {
            "bat" = "BAT2";
          };
          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "󰂰 {volume}%";
            "nospacing" = 1;
            "tooltip" = false;
            # "tooltip-format" = "Volume : {volume}%";
            "format-muted" = "󰖁 {volume}%";
            "format-icons" = {
              "headphone" = "";
              "default" = ["󰕿" "󰖀"  "󰕾"  ""];
            };
            "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "scroll-step" = 5;
          };
        };
      };

      style = ''
        * {
          font-family: JetBrainsMono NFP;
          font-size: 13px;
        }

        #window,
        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #backlight,
        #network,
        #pulseaudio,
        #custom-notification,
        #tray {
          padding: 0 10px;
          border-radius: 15px;
          background: #11111b;
          color: #b4befe;
          box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
          margin-top: 10px;
          margin-bottom: 10px;
          margin-right: 10px;
        }

        /* make window module transparent when no windows present */
        window#waybar.empty #window {
          all: unset;
          background-color: transparent;
        }

        window#waybar {
          background-color: transparent;
        }

        #workspaces button label {
          color: #89b4fa;
          font-weight: bolder;
        }

        #workspaces button.active label {
          color: #11111b;
          font-weight: bolder;
        }

        #workspaces {
          background-color: transparent;
          margin-top: 10px;
          margin-bottom: 10px;
          margin-right: 10px;
          margin-left: 25px;
        }

        #workspaces button {
          box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
          background-color: #11111b;
          border-radius: 15px;
          margin-right: 10px;
          padding: 10px;
          padding-top: 4px;
          padding-bottom: 2px;
          font-weight: bolder;
          color: #89b4fa;
          transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
        }

        #workspaces button.active {
          padding-right: 20px;
          box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
          padding-left: 20px;
          padding-bottom: 3px;
          background: rgb(203, 166, 247);
          background: radial-gradient(
            circle,
            rgba(203, 166, 247, 1) 0%,
            rgba(193, 168, 247, 1) 12%,
            rgba(249, 226, 175, 1) 19%,
            rgba(189, 169, 247, 1) 20%,
            rgba(182, 171, 247, 1) 24%,
            rgba(198, 255, 194, 1) 36%,
            rgba(177, 172, 247, 1) 37%,
            rgba(170, 173, 248, 1) 48%,
            rgba(255, 255, 255, 1) 52%,
            rgba(166, 174, 248, 1) 52%,
            rgba(160, 175, 248, 1) 59%,
            rgba(148, 226, 213, 1) 66%,
            rgba(155, 176, 248, 1) 67%,
            rgba(152, 177, 248, 1) 68%,
            rgba(205, 214, 244, 1) 77%,
            rgba(148, 178, 249, 1) 78%,
            rgba(144, 179, 250, 1) 82%,
            rgba(180, 190, 254, 1) 83%,
            rgba(141, 179, 250, 1) 90%,
            rgba(137, 180, 250, 1) 100%
          );
          background-size: 400% 400%;
          animation: gradient_f 20s ease-in-out infinite;
          transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        @keyframes gradient {
          0% {
            background-position: 0% 50%;
          }
          50% {
            background-position: 100% 30%;
          }
          100% {
            background-position: 0% 50%;
          }
        }

        @keyframes gradient_f {
          0% {
            background-position: 0% 200%;
          }
          50% {
            background-position: 200% 0%;
          }
          100% {
            background-position: 400% 200%;
          }
        }

        @keyframes gradient_f_nh {
          0% {
            background-position: 0% 200%;
          }
          100% {
            background-position: 200% 200%;
          }
        }

        #window {
          background: rgb(148, 226, 213);
          background: linear-gradient(
            52deg,
            rgba(148, 226, 213, 1) 0%,
            rgba(137, 220, 235, 1) 19%,
            rgba(116, 199, 236, 1) 43%,
            rgba(137, 180, 250, 1) 56%,
            rgba(180, 190, 254, 1) 80%,
            rgba(186, 187, 241, 1) 100%
          );
          background-size: 300% 300%;
          text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
          animation: gradient 15s ease infinite;
          font-weight: bolder;

          color: #2a3b80;
        }

        #clock label {
          color: #11111b;
          font-weight: bolder;
        }

        #clock {
          background: rgb(205, 214, 244);
          background: linear-gradient(
            118deg,
            rgba(205, 214, 244, 1) 5%,
            rgba(243, 139, 168, 1) 5%,
            rgba(243, 139, 168, 1) 20%,
            rgba(205, 214, 244, 1) 20%,
            rgba(205, 214, 244, 1) 40%,
            rgba(243, 139, 168, 1) 40%,
            rgba(243, 139, 168, 1) 60%,
            rgba(205, 214, 244, 1) 60%,
            rgba(205, 214, 244, 1) 80%,
            rgba(243, 139, 168, 1) 80%,
            rgba(243, 139, 168, 1) 95%,
            rgba(205, 214, 244, 1) 95%
          );

          background-size: 200% 300%;

          animation: gradient_f_nh 4s linear infinite;
          margin-right: 25px;
          color: #11111b;
          text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);

          font-size: 15px;
          padding-top: 5px;
          padding-right: 21px;
          font-weight: bolder;
          padding-left: 20px;
        }

        #battery {
          /* background-color: #99f092; */
          color: #f9e2af;
          font-weight: bolder;
          padding-left: 15px;
          padding-right: 15px;
        }

        @keyframes blink {
          to {
            background-color: #f9e2af;
            color: #96804e;
          }
        }

        #battery.critical:not(.charging) {
          /* background-color: #f38ba8; */
          color: #bf5673;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #cpu label {
          color: #89dceb;
        }

        #cpu {
          color: #89b4fa;
        }

        #memory {
          /* background-color: #cba6f7; */
          color: #a6e3a1;
          font-weight: bolder;
        }

        #backlight {
          /* background-color: #ffeabd; */
          color: #cba6f7;
          font-weight: bolder;
        }

        #disk {
          /* background-color: #f5c2e7; */
          color: #89dceb;
          font-weight: bolder;
        }

        #pulseaudio {
          /* background-color: #fab387; */
          color: #f38ba8;
          font-weight: bolder;
        }

        /* #pulseaudio.muted { */
        /*   background-color: #90b1b1; */
        /* } */

        #tray {
          /* background-color: #2980b9; */
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
        }
      '';
    };
  };
}
