{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.home.program.neovim;
in
{
  options.modules.home.program.neovim.enable = lib.mkEnableOption "Enable Neovim configuration";

  config = lib.mkIf cfg.enable {
    xdg.configFile."nvim/snippets".source = inputs.self + "/nvim/snippets";
    xdg.configFile."stylua/stylua.toml".text = ''
      indent_type = "Spaces"
      indent_width = 2
      column_width = 120
      quote_style = "AutoPreferSingle"
    '';
    xdg.configFile.".clang-format".text = ''
      BasedOnStyle: Google
      BreakBeforeBraces: Allman
      IndentWidth: 2
      UseTab: Never
      ColumnLimit: 0
      AllowShortIfStatementsOnASingleLine: true
      AllowShortFunctionsOnASingleLine: true
      AllowShortLoopsOnASingleLine: true
      PointerAlignment: Left
      AccessModifierOffset: -2
    '';

    programs.neovim =
      let
        helperDir = inputs.self + "/nvim/helper";
        helperFiles = builtins.readDir helperDir;
        luaFiles = lib.attrNames (
          lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) helperFiles
        );
        loadHelperFiles = lib.concatMapStringsSep "\n\n" (name: ''
          ;(function()
            ${builtins.readFile (helperDir + "/" + name)}
          end)()
        '') luaFiles;

        toLuaFile = file: builtins.readFile (inputs.self + "/nvim/" + file + ".lua");
      in
      {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        plugins = with pkgs.vimPlugins; [
          blink-copilot
          nvim-lspconfig
          nvim-treesitter.withAllGrammars

          {
            plugin = autoclose-nvim;
            config = toLuaFile "plugin/autoclose";
          }
          {
            plugin = blink-cmp;
            config = toLuaFile "plugin/blink-cmp";
          }
          {
            plugin = catppuccin-nvim;
            config = toLuaFile "plugin/colorscheme";
          }
          {
            plugin = bufferline-nvim;
            config = toLuaFile "plugin/bufferline";
          }
          {
            plugin = lualine-nvim;
            config = toLuaFile "plugin/lualine";
          }
          {
            plugin = mini-icons;
            config = toLuaFile "plugin/mini-icons";
          }
          {
            plugin = mini-files;
            config = toLuaFile "plugin/mini-files";
          }
          {
            plugin = mini-ai;
            config = toLuaFile "plugin/mini-ai";
          }
          {
            plugin = mini-move;
            config = toLuaFile "plugin/mini-move";
          }
          {
            plugin = snacks-nvim;
            config = toLuaFile "plugin/snacks";
          }
          {
            plugin = gitsigns-nvim;
            config = toLuaFile "plugin/gitsigns";
          }
          {
            plugin = flash-nvim;
            config = toLuaFile "plugin/flash";
          }
          {
            plugin = conform-nvim;
            config = toLuaFile "plugin/formatter";
          }
          {
            plugin = competitest-nvim;
            config = toLuaFile "plugin/competitest";
          }
          {
            plugin = nvim-surround;
            config = toLuaFile "plugin/surround";
          }
          {
            plugin = treesj;
            config = toLuaFile "plugin/treesj";
          }
          {
            plugin = nvim-treesitter-textobjects;
            config = toLuaFile "plugin/treesitter-textobjects";
          }
          {
            plugin = vim-tmux-navigator;
            config = toLuaFile "plugin/tmux-navigator";
          }
        ];

        extraPackages = with pkgs; [
          wl-clipboard
          xclip
          lazygit
          ripgrep

          # Lsp
          lua-language-server
          fish-lsp
          clang-tools
          basedpyright
          bash-language-server
          nixd
          copilot-language-server

          # Formatter
          stylua
          black
          prettierd
          nixfmt
        ];

        initLua = ''
          ${loadHelperFiles}

          ${toLuaFile "config/options"}
          ${toLuaFile "config/keymaps"}
          ${toLuaFile "config/autocmds"}
          ${toLuaFile "config/cmds"}
          ${toLuaFile "config/lsp"}
        '';
      };
  };
}
