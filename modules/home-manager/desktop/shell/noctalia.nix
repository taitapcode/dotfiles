{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.modules.home.desktop.shell.noctalia;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
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
          sidebar = "full";
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
            "onlyoffice-desktopeditors"
          ];
          reserve_space = false;
          show_dots = true;
        };

        lockscreen_widgets = {
          enabled = false;
          schema_version = 2;
          widget_order = [ "lockscreen-login-box@eDP-1" ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget."lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
        };

        notification.position = "top_center";

        plugins.enabled = [ ];

        shell = {
          avatar_path = "${inputs.self}/assets/images/profile.jpg";
          corner_radius_scale = 1.6;
          lang = "en";
          niri_overview_type_to_launch_enabled = true;
          screen_time_enabled = true;
          settings_show_advanced = true;
          show_location = false;
          panel.clipboard_placement = "attached";
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
          directory = "${inputs.self}/assets/images/wallpapers";
          default.path = "${inputs.self}/assets/images/wallpapers/wallhaven-8gr6l2.jpg";
          transition_on_startup = true;
        };

        widget = {
          battery = {
            display_mode = "graphic";
            show_label = false;
          };
          clock = {
            color = "secondary";
            font_weight = "700";
            format = "{: %H:%M - %A, %d/%m/%Y }";
          };
          cpu.display = "text";
          media.hide_when_no_media = true;
          network.show_label = false;
          ram = {
            display = "text";
            show_label = false;
          };
          workspaces = {
            display = "none";
            hide_when_empty = true;
          };
        };
      };
    };
  };
}
