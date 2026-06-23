{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home-manager/niri.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/zen-browser.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/ghostty.nix
  ];

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
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
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
    niri.enable = true;
    git.enable = true;
    zen-browser.enable = true;
    fish.enable = true;
    neovim.enable = true;
    ghostty.enable = true;
  };
}
