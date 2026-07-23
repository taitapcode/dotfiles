{
  pkgs,
  config,
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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services.upower.enable = true;

  # Asus config
  services.asusd.asusdConfig.text = ''
    (
      charge_control_end_threshold: 80,
      base_charge_control_end_threshold: 80,
      disable_nvidia_powerd_on_battery: true,
      ac_command: "",
      bat_command: "",
      platform_profile_linked_epp: true,
      platform_profile_on_battery: Quiet,
      change_platform_profile_on_battery: true,
      platform_profile_on_ac: Performance,
      change_platform_profile_on_ac: true,
      profile_quiet_epp: Power,
      profile_balanced_epp: BalancePower,
      profile_custom_epp: Performance,
      profile_performance_epp: Performance,
      ac_profile_tunings: {
        Performance: (
          enabled: false,
          group: {},
        ),
        Quiet: (
          enabled: false,
          group: {},
        ),
        Balanced: (
          enabled: false,
          group: {},
        ),
      },
      dc_profile_tunings: {
        Quiet: (
          enabled: false,
          group: {},
        ),
        Balanced: (
          enabled: false,
          group: {},
        ),
        Performance: (
          enabled: false,
          group: {},
        ),
      },
      armoury_settings: {},
    )
  '';

  fileSystems."/mnt/Storage" = {
    device = "/dev/disk/by-uuid/1A5E3A2E5E3A02D5";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "exec"
      "rw"
      "nofail"
      "umask=000"
      "force"
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ubuntu-classic
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
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
      "power"
    ];

    shell = pkgs.fish;
    packages = with pkgs; [
      nautilus
      peazip
      onlyoffice-desktopeditors
      btop
      loupe

      self.packages.${pkgs.stdenv.hostPlatform.system}.note
      self.packages.${pkgs.stdenv.hostPlatform.system}.rcc
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
      xdg-desktop-portal-gnome
    ];
    config.common = {
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
    };
  };

  services.asusd.enable = true;
  powerManagement.powertop.enable = false;

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

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaPersistenced = true;
    powerManagement.finegrained = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

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
    steam.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
