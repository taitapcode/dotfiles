{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.home.programs.opencode;
in
{
  options.modules.home.programs.opencode.enable = lib.mkEnableOption "Enable Opencode configuration";

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;

      extraPackages = with pkgs; [
        lua-language-server
        fish-lsp
        clang-tools
        basedpyright
        bash-language-server
        nixd
      ];

      tui = {
        theme = "catppuccin";
      };

      settings = {
        lsp = {
          nixd = {
            command = [ "nixd" ];
            extensions = [ ".nix" ];
          };
          lua_ls = {
            command = [ "lua-language-server" ];
            extensions = [ ".lua" ];
          };
          fish_lsp = {
            command = [ "fish-lsp" ];
            extensions = [ ".fish" ];
          };
          clangd = {
            command = [ "clangd" ];
            extensions = [
              ".c"
              ".cpp"
              ".h"
              ".hpp"
            ];
          };
          basedpyright = {
            command = [
              "basedpyright-langserver"
              "--stdio"
            ];
            extensions = [ ".py" ];
          };
          bashls = {
            command = [
              "bash-language-server"
              "start"
            ];
            extensions = [
              ".sh"
              ".bash"
            ];
          };
        };
      };

      commands = {
        commit = ''
          ---
          description: Generate conventional commit message(s) from staged diff
          ---

          Generate conventional commit message(s) from the staged git diff.

          Rules:
          - If nothing is staged, run `git add -A` first, then proceed
          - Prefix: feat, fix, chore, refactor, docs, test, ci, perf, style
          - All text lowercase (e.g. "feat: add login page")
          - Subject line under 72 characters
          - No period at the end
          - If the diff covers multiple unrelated changes, split into separate commits
          - Each commit should be atomic and self-contained
          - After writing the commit message, stage and commit with `git commit -m "<message>"`

          $ARGUMENTS
        '';
      };
    };
  };
}
