{
  config,
  lib,
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
      tui = {
        theme = "catppuccin";
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
          - Output ONLY the commit message(s), nothing else

          $ARGUMENTS
        '';
      };
    };
  };
}
