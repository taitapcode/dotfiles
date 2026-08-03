{
  config,
  lib,
  inputs,
  self,
  ...
}:
let
  cfg = config.modules.home.desktop.shell.noctalia;
  wallpaperPath = "${self}/assets/wallpapers";
  defaultWallpaper = "${wallpaperPath}/3.png";
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  options.modules.home.desktop.shell.noctalia.enable =
    lib.mkEnableOption "Enable Noctalia shell configuration";

  config = lib.mkIf cfg.enable {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        audio.enable_overdrive = true;

        backdrop.enabled = true;

        bar = {
          order = [ "top" ];
          top = {
            background_opacity = 0.9;
            end = [
              "tray"
              "cpu"
              "ram"
              "brightness"
              "volume"
              "clipboard"
              "bluetooth"
              "network"
              "battery"
              "notifications"
              "session"
            ];
            margin_edge = 0;
            margin_ends = 0;
            radius = 0;
            shadow = false;
            start = [ "workspaces" ];
            widget_spacing = 8;
          };
        };

        control_center = {
          sidebar = "compact";
          sidebar_section = "none";
        };

        desktop_widgets.enabled = false;

        dock = {
          auto_hide = true;
          background_opacity = 0.85;
          cross_axis_padding = 0;
          enabled = true;
          icon_size = 70;
          inactive_opacity = 0.95;
          item_spacing = 0;
          main_axis_padding = 0;
          pinned = [
            "com.mitchellh.ghostty"
            "zen-beta"
            "org.gnome.Nautilus"
            "vesktop"
            "org.pwmt.zathura"
            "LocalSend"
            "anki"
            "steam"
            "org.qbittorrent.qBittorrent"
            "onlyoffice-desktopeditors"
          ];
          position = "bottom";
          reserve_space = false;
          show_dots = true;
          smart_auto_hide = true;
        };

        location.address = "Ho Chi Minh City, Vietnam";
        notification.position = "top_center";

        plugins.enabled = [ ];

        shell = {
          avatar_path = "${self}/assets/profile.jpg";
          corner_radius_scale = 1.6;
          lang = "en";
          niri_overview_type_to_launch_enabled = true;
          screen_time_enabled = true;
          settings_show_advanced = true;
          show_location = true;

          launcher = {
            categories = false;
            providers = {
              emoji = {
                global = true;
                prefix = "";
              };
              session.global = false;
              wallpaper.global = false;
            };
          };

          panel = {
            clipboard_placement = "floating";
            polkit_placement = "attached";
          };

          screenshot.confirm_region = true;
        };

        theme = {
          builtin = "Catppuccin";
          community_palette = "Oxocarbon";
          mode = "dark";
          source = "wallpaper";
          wallpaper_scheme = "m3-content";
          templates = {
            community_ids = [ ];
            enable_builtin_templates = false;
            enable_community_templates = false;
          };
        };

        wallpaper = {
          directory = wallpaperPath;
          transition_on_startup = true;
          default.path = defaultWallpaper;
          last.path = defaultWallpaper;
        };

        widget = {
          battery = {
            display_mode = "graphic";
            show_label = true;
          };
          clock = {
            color = "secondary";
            format = "{: %H:%M - %A, %d/%m/%Y }";
          };
          media.hide_when_no_media = true;
          network.show_label = false;
          workspaces = {
            hide_when_empty = true;
            show_labels = false;
          };
        };
      };
    };
  };
}
