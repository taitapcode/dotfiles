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
        loadHelper = file: builtins.readFile (self + "/nvim/helper/" + file + ".lua");
        loadConfig = file: builtins.readFile (self + "/nvim/config/" + file + ".lua");
        loadPluginConfig = file: builtins.readFile (self + "/nvim/plugin/" + file + ".lua");
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
            config = loadPluginConfig "autoclose";
          }
          {
            plugin = blink-cmp;
            config = loadPluginConfig "blink-cmp";
          }
          {
            plugin = catppuccin-nvim;
            config = loadPluginConfig "colorscheme";
          }
          {
            plugin = bufferline-nvim;
            config = loadPluginConfig "bufferline";
          }
          {
            plugin = lualine-nvim;
            config = loadPluginConfig "lualine";
          }
          {
            plugin = mini-icons;
            config = loadPluginConfig "mini-icons";
          }
          {
            plugin = mini-files;
            config = loadPluginConfig "mini-files";
          }
          {
            plugin = mini-ai;
            config = loadPluginConfig "mini-ai";
          }
          {
            plugin = mini-move;
            config = loadPluginConfig "mini-move";
          }
          {
            plugin = snacks-nvim;
            config = loadPluginConfig "snacks";
          }
          {
            plugin = gitsigns-nvim;
            config = loadPluginConfig "gitsigns";
          }
          {
            plugin = flash-nvim;
            config = loadPluginConfig "flash";
          }
          {
            plugin = conform-nvim;
            config = loadPluginConfig "formatter";
          }
          {
            plugin = competitest-nvim;
            config = loadPluginConfig "competitest";
          }
          {
            plugin = nvim-surround;
            config = loadPluginConfig "surround";
          }
          {
            plugin = treesj;
            config = loadPluginConfig "treesj";
          }
          {
            plugin = nvim-treesitter-textobjects;
            config = loadPluginConfig "treesitter-textobjects";
          }
          {
            plugin = vim-tmux-navigator;
            config = loadPluginConfig "tmux-navigator";
          }
          {
            plugin = render-markdown-nvim;
            config = loadPluginConfig "render-markdown";
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
          ${loadHelper "keymap"}
          ${loadHelper "trailspace"}
          ${loadHelper "fcitx5"}

          ${loadConfig "options"}
          ${loadConfig "keymaps"}
          ${loadConfig "autocmds"}
          ${loadConfig "cmds"}
          ${loadConfig "lsp"}
        '';
      };
  };
}
