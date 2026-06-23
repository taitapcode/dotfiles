{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.fish;
in
{
  imports = [
    ./fzf.nix
    ./zoxide.nix
    ./yazi.nix
  ];

  options.modules.home.fish.enable = lib.mkEnableOption "Enable Fish shell configuration";

  config = lib.mkIf cfg.enable {
    modules.home = {
      fzf.enable = true;
      zoxide.enable = true;
      yazi.enable = true;
    };

    programs.fish = {
      enable = true;

      shellAliases = {
        # Navigation
        ".." = "z ..";
        "..." = "z ../..";
        "3.." = "z ../../..";
        # Ls (Eza)
        ls = "eza --icons --group-directories-first";
        ll = "ls --header --long";
        la = "ll --all";
        lt = "ll --tree --level=2";
        lta = "lt --all";
        # Cat (Bat)
        cat = "bat";
        # Cp / Rm / Grep
        cp = "cp -i";
        cf = "cp -r";
        rf = "rm -rf";
        grep = "grep --color=auto";
        egrep = "egrep --color=auto";
        fgrep = "fgrep --color=auto";
        # Git
        gcl = "git clone --depth 1";
        gi = "git init";
        ga = "git add";
        gc = "git commit -m";
        gp = "git push origin master";
        gst = "git status";
        # Others
        tmx = "tmux";
        cl = "clear";
        lg = "lazygit";
        v = "nvim";
      };

      functions = {
        fish_greeting = { body = ""; };
        fish_mode_prompt = { body = ""; };

        _git_branch_name = { body = "echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')"; };

        _is_git_dirty = {
          body = ''
            set -l show_untracked (git config --bool bash.showUntrackedFiles)
            set -l untracked
            if [ "$theme_display_git_untracked" = no -o "$show_untracked" = false ]
                set untracked '--untracked-files=no'
            end
            echo (command git status -s --ignore-submodules=dirty $untracked 2> /dev/null)
          '';
        };

        fish_prompt = {
          body = ''
            set -l last_status $status
            set -l cyan (set_color -o cyan)
            set -l yellow (set_color -o yellow)
            set -l red (set_color -o red)
            set -l blue (set_color -o blue)
            set -l green (set_color -o green)
            set -l normal (set_color normal)
            if test $last_status = 0
                set arrow "$green➜"
            else
                set arrow "$red➜"
            end
            set -l cwd $cyan(basename (prompt_pwd))
            if [ (_git_branch_name) ]
                set -l git_branch $red(_git_branch_name)
                set git_info "$blue git:($git_branch$blue)"
                if [ (_is_git_dirty) ]
                    set -l dirty " $yellow✗"
                    set git_info "$git_info$dirty"
                end
            end
            echo -n -s $arrow ' ' $cwd $git_info $normal ' '
          '';
        };
      };

      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
  };
}
