{ config, lib, pkgs, ... }:
let
  cfg = config.modules.home.fish;
in
{
  options.modules.home.fish.enable = lib.mkEnableOption "Enable Fish shell configuration";

  config = lib.mkIf cfg.enable {
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
        # Tmux & Others
        tmx = "tmux";
        mux = "tmuxinator";
        cl = "clear";
        lg = "lazygit";
      };

      functions = {
        fish_greeting = {
          body = "";
        };
        
        fish_mode_prompt = {
          body = "";
        };

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
                    set -l dirty "$yellow✗"
                    set git_info "$git_info$dirty"
                end
            end
            echo -n -s $arrow ' ' $cwd $git_info $normal ' '
          '';
        };

        # Phím tắt bang-bang (!! và !$)
        __history_previous_command = {
          body = ''
            switch (commandline -t)
                case "!"
                    commandline -t $history[1]
                    commandline -f repaint
                case "*"
                    commandline -i !
            end
          '';
        };
        __history_previous_command_arguments = {
          body = ''
            switch (commandline -t)
                case "!"
                    commandline -t ""
                    commandline -f history-token-search-backward
                case "*"
                    commandline -i '$'
            end
          '';
        };

        oc = { body = "opencode $argv"; };
      };

      # 4. Cấu hình Key Bindings (Từ fish_user_key_bindings.fish và bang-bang.fish)
      interactiveShellInit = ''
        # Bật Vi key bindings
        fish_vi_key_bindings

        # Cấu hình phím cho bang-bang ở cả 2 mode (default và insert)
        bind --erase !
        bind --erase '$'
        bind --mode default ! __history_previous_command
        bind --mode default '$' __history_previous_command_arguments
        bind --mode insert ! __history_previous_command
        bind --mode insert '$' __history_previous_command_arguments

        # Khởi tạo zoxide (Từ conf.d/zoxide.fish)
        zoxide init fish | source

        # Khởi tạo fzf (Từ conf.d/fzf.fish)
        fzf --fish | source
      '';

      # 5. Khởi tạo khi chạy Shell (Từ các file conf.d còn lại)
      shellInit = ''
        # Thêm các đường dẫn vào PATH (Từ env.fish và bun.fish)
        fish_add_path $HOME/go/bin $HOME/.bun/bin $HOME/.cache/.bun/bin $HOME/.local/share/bin $HOME/.cache/bun/bin

        # Cấu hình FZF (Từ conf.d/fzf.fish)
        set -g fzf_fd_opts -H -E .git -E node_modules
        set -g FZF_DEFAULT_COMMAND 'fd . -H -E .git -E node_modules'
        set -Ux FZF_DEFAULT_OPTS " --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
        set -Ux FZF_CTRL_T_OPTS "--preview 'if test -d {}; eza --tree --color=always {} | head -200; else; bat --style=numbers --color=always --line-range :500 {}; end'"
        set -gx FZF_CTRL_R_OPTS " --preview 'echo {}' --preview-window down:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --color 'header:italic' --header 'Press CTRL-/ to toggle full command view'"
        set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always --level 2 {} | head -200'"
      '';
    };
  };
}
