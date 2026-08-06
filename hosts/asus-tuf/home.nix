{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ../../modules/home-manager
  ];

  home.username = "tai";
  home.homeDirectory = "/home/tai";
  home.stateVersion = "26.05";

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.banana-cursor;
    name = "Banana";
    size = 28;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-icon-theme;
    };

    font = {
      name = "Sans";
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-color-scheme = "prefer-dark";
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "blue";
    gtk.icon.enable = false;
    kvantum.enable = false;
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "zen-beta.desktop";
    "x-scheme-handler/https" = "zen-beta.desktop";
    "text/html" = "zen-beta.desktop";

    "application/pdf" = "org.pwmt.zathura.desktop";
    "application/epub+zip" = "org.pwmt.zathura.desktop";

    "application/msword" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
      "onlyoffice-desktopeditors.desktop";

    "image/png" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/svg+xml" = "org.gnome.Loupe.desktop";

    "video/mp4" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "audio/mpeg" = "mpv.desktop";
    "audio/flac" = "mpv.desktop";
    "audio/ogg" = "mpv.desktop";

    "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";
    "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";

    "inode/directory" = "org.gnome.Nautilus.desktop";
  };

  modules.home = {
    programs = {
      fish.enable = true;
      fcitx5.enable = true;
      git.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      opencode.enable = true;
      nh.enable = true;
      eza.enable = true;
      bat.enable = true;
      bun.enable = true;
      mangohud.enable = true;
      kanshi.enable = true;
    };
    app = {
      zen-browser.enable = true;
      ghostty.enable = true;
      vesktop.enable = true;
      mpv.enable = true;
      # anki.enable = true;
      qbittorrent.enable = true;
      zathura.enable = true;
      helium.enable = true;
    };
    desktop.niri.enable = true;
  };
}
