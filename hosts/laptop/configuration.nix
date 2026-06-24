{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.nixosModules.niri
    ./hardware.nix
    ../../modules/nixos
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  environment.sessionVariables = {
    NH_FLAKE = "/home/tai/.dotfiles";
  };

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    ghostty
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
      nerd-fonts.symbols-only
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
      bat
      eza
      lazygit
      opencode
      nh
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.tai = import ./home.nix;
    backupFileExtension = "backup";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
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
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    };
    fish.enable = true;
  };

  modules.nixos = {
    keyd.enable = true;
    sddm.enable = true;
    fcitx5.enable = true;
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
