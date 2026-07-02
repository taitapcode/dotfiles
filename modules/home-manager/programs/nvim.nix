{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  cfg = config.modules.home.programs.neovim;
  nvimConfig = "${self}/config/nvim/";
in
{
  options.modules.home.programs.neovim.enable = lib.mkEnableOption "Enable Neovim configuration";

  config = lib.mkIf cfg.enable {
    xdg.configFile."nvim/snippets".source = nvimConfig + "snippets";
    xdg.configFile."nvim/stylua.toml".source = nvimConfig + "stylua.toml";
    xdg.configFile."nvim/clang-format".source = nvimConfig + "clang-format";

    programs.neovim =
      let
        loadLuaFile = path: builtins.readFile (nvimConfig + path);
        loadHelper = file: loadLuaFile ("helper/" + file + ".lua");
        loadConfig = file: loadLuaFile ("config/" + file + ".lua");
        loadPluginConfig = file: loadLuaFile ("plugin/" + file + ".lua");
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
