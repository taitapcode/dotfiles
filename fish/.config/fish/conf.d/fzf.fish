# Config
set -g fzf_fd_opts -H -E .git -E node_modules
set -g FZF_DEFAULT_COMMAND fdfind . -H -E .git -E node_modules
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Source fzf
fzf --fish | source
