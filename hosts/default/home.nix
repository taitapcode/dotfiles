{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
in {
  home.username = "tai";
  home.homeDirectory = "/home/tai";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    brave

    nodejs_23
    gcc14
    rustc
    python314
    cargo

    unzip
    wget
    wl-clipboard-x11
    curl

    nerd-fonts.caskaydia-cove
    noto-fonts
    noto-fonts-color-emoji
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/dotfiles/nvim/.config/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable catppuccin theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
    nvim.enable = false;
  };

  # Programs
  programs = {
    home-manager.enable = true;
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    gh.enable = true;
    lazygit.enable = true;

    kitty = {
      enable = true;
      settings = {
        font_family = "Caskaydia Cove NF";
        font_size = 18;
      };
    };

    neovim = {
      enable = true;
      vimAlias = true;
    };

    fish = {
      enable = true;
      shellAliases = {
        ".." = "z ..";
	      "..." = "z ../..";
	      cl = "clear";
        rf = "rm -rf";
        lg = "lazygit";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        {
          name = "bang-bang";
          src = pkgs.fishPlugins.bang-bang;
        }
      ];
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = "$directory$character";
        right_format = "$all";
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        directory = {
          truncation_length = 1;
        };
      };
    };

    git = {
      enable = true;
      userEmail = "hoangductai2007@gmail.com";
      userName = "taitapcode";
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      tmux.enableShellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      extraOptions = [ "--icons" "--group-directories-first" ];
    };

    nh = {
      enable = true;
      flake = "/home/tai/nixos-config";
      clean.enable = true;
    };

    tmux = {
      enable = true;
      prefix = "C-s";
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
