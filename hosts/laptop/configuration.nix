# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware.nix
      inputs.niri.nixosModules.niri
    ];

  # Use the GRUB boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    ghostty
    lazygit
    tmux
    weston
    xwayland
  ];

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    ubuntu-classic
    liberation_ttf
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    twemoji-color-font
    nerd-fonts.symbols-only 
  ];


  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "weston"; 
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = [ "gnome" ];
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
  # programs.firefox.enable = true;
  # programs.dms-shell.enable = true;
  # programs.niri.enable = true;
  programs.fish.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "esc";
	  escape = "capslock";
        };
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Ensure hardware acceleration / graphics drivers are active
  hardware.graphics.enable = true;

  # Define user
  users.users.tai = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      bat
      eza
      git
      lazygit
    ];
  };
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.tai = import ./home.nix;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}

