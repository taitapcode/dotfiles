{
  pkgs,
  ...
}:

{
  imports = [ ../../modules/home-manager ];

  home.username = "tai";
  home.homeDirectory = "/home/tai";
  home.stateVersion = "26.05";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.banana-cursor;
    name = "Banana";
    size = 28;
  };

  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-mocha-lavender-standard+normal";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
      };
    };

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
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  modules.home = {
    program = {
      fish.enable = true;
      fcitx5.enable = true;
      git.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };
    app = {
      zen-browser.enable = true;
      ghostty.enable = true;
    };
    desktop.niri.enable = true;
  };
}
