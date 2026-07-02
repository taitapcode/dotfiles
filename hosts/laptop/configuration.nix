{
  pkgs,
  inputs,
  self,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../modules/nixos
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl

    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      dejavu_fonts
      ubuntu-classic
      liberation_ttf
      roboto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      twemoji-color-font
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Liberation Serif"
          "Times New Roman"
        ];
        sansSerif = [
          "Ubuntu"
          "Noto Sans"
          "Arial"
        ];
        monospace = [
          "CaskaydiaCove Nerd Font"
          "JetBrainsMono Nerd Font"
        ];
      };
    };
  };

  # Define user
  users.users.tai = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];

    shell = pkgs.fish;
    packages = with pkgs; [
      nautilus
      peazip
      onlyoffice-desktopeditors
      btop
      loupe

      self.packages.${pkgs.stdenv.hostPlatform.system}.note
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs self; };
    users.tai = import ./home.nix;
    backupFileExtension = "backup";
  };

  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common = {
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      default = [ "gtk" ];
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Allow proprietary/unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  # Programs
  programs = {
    niri = {
      enable = true;
      useNautilus = true;
    };
    fish.enable = true;
  };

  modules.nixos = {
    keyd.enable = true;
    sddm.enable = true;
    fcitx5.enable = true;
    waydroid.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Ensure hardware acceleration / graphics drivers are active
  hardware.graphics.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
