# Config
set -g fzf_fd_opts -H -E .git -E node_modules
set -g FZF_DEFAULT_COMMAND fdfind . -H -E .git -E node_modules
set -Ux FZF_DEFAULT_OPTS "
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
set -Ux FZF_CTRL_T_OPTS "--preview 'if test -d {}; eza --tree --color=always {} | head -200; else; bat --style=numbers --color=always --line-range :500 {}; end'"
set -gx FZF_CTRL_R_OPTS "
  --preview 'echo {}' --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --color 'header:italic'
  --header 'Press CTRL-/ to toggle full command view'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always --level 2 {} | head -200'"

# Source fzf
fzf --fish | source
