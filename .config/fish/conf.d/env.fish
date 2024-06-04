# Set default editor
set -gx EDITOR nvim

# Fzf
set -g fzf_fd_opts -H -E .git -E node_modules
set -g FZF_DEFAULT_COMMAND fdfind . -H -E .git -E node_modules
set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# Pfetch
set -gx PF_CUSTOM_LOGOS ~/.config/pfetch/custom_logos
set -gx PF_ASCII kitty
set -gx PF_PAD3 5
