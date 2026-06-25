{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  cfg = config.modules.home.program.neovim;
in
{
  options.modules.home.program.neovim.enable = lib.mkEnableOption "Enable Neovim configuration";

  config = lib.mkIf cfg.enable {
    xdg.configFile."nvim/snippets".source = self + "/nvim/snippets";
    xdg.configFile."nvim/stylua.toml".source = self + "/nvim/stylua.toml";
    xdg.configFile."nvim/clang-format".source = self + "/nvim/clang-format";

    programs.neovim =
      let
        loadLuaFile = base: builtins.readFile (self + "/nvim/" + base + ".lua");
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
            config = loadLuaFile "plugin/autoclose";
          }
          {
            plugin = blink-cmp;
            config = loadLuaFile "plugin/blink-cmp";
          }
          {
            plugin = catppuccin-nvim;
            config = loadLuaFile "plugin/colorscheme";
          }
          {
            plugin = bufferline-nvim;
            config = loadLuaFile "plugin/bufferline";
          }
          {
            plugin = lualine-nvim;
            config = loadLuaFile "plugin/lualine";
          }
          {
            plugin = mini-icons;
            config = loadLuaFile "plugin/mini-icons";
          }
          {
            plugin = mini-files;
            config = loadLuaFile "plugin/mini-files";
          }
          {
            plugin = mini-ai;
            config = loadLuaFile "plugin/mini-ai";
          }
          {
            plugin = mini-move;
            config = loadLuaFile "plugin/mini-move";
          }
          {
            plugin = snacks-nvim;
            config = loadLuaFile "plugin/snacks";
          }
          {
            plugin = gitsigns-nvim;
            config = loadLuaFile "plugin/gitsigns";
          }
          {
            plugin = flash-nvim;
            config = loadLuaFile "plugin/flash";
          }
          {
            plugin = conform-nvim;
            config = loadLuaFile "plugin/formatter";
          }
          {
            plugin = competitest-nvim;
            config = loadLuaFile "plugin/competitest";
          }
          {
            plugin = nvim-surround;
            config = loadLuaFile "plugin/surround";
          }
          {
            plugin = treesj;
            config = loadLuaFile "plugin/treesj";
          }
          {
            plugin = nvim-treesitter-textobjects;
            config = loadLuaFile "plugin/treesitter-textobjects";
          }
          {
            plugin = vim-tmux-navigator;
            config = loadLuaFile "plugin/tmux-navigator";
          }
          {
            plugin = render-markdown-nvim;
            config = loadLuaFile "plugin/render-markdown";
          }
        ];

        extraPackages = with pkgs; [
          wl-clipboard
          xclip
          lazygit
          ripgrep
          fzf

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
          ${loadLuaFile "helper/keymap"}
          ${loadLuaFile "helper/trailspace"}
          ${loadLuaFile "helper/fcitx5"}

          ${loadLuaFile "config/options"}
          ${loadLuaFile "config/keymaps"}
          ${loadLuaFile "config/autocmds"}
          ${loadLuaFile "config/cmds"}
          ${loadLuaFile "config/lsp"}
        '';
      };
  };
}
