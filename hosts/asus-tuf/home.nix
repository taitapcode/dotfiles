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
    };
    app = {
      zen-browser.enable = true;
      ghostty.enable = true;
      vesktop.enable = true;
      mpv.enable = true;
      anki.enable = true;
      qbittorrent.enable = true;
      zathura.enable = true;
    };
    desktop.niri.enable = true;
  };
}
