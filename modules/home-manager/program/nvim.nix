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
        toHelperFile = file: builtins.readFile (self + "/nvim/helper/" + file + ".lua");
        toLuaFile = file: builtins.readFile (self + "/nvim/" + file + ".lua");
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
          {
            plugin = render-markdown-nvim;
            config = toLuaFile "plugin/render-markdown";
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
          ${toHelperFile "keymap"}
          ${toHelperFile "trailspace"}
          ${toHelperFile "fcitx5"}

          ${toLuaFile "config/options"}
          ${toLuaFile "config/keymaps"}
          ${toLuaFile "config/autocmds"}
          ${toLuaFile "config/cmds"}
          ${toLuaFile "config/lsp"}
        '';
      };
  };
}
