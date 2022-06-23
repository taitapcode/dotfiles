# Default program
export EDITOR="nvim"

# Fzf
export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*' -not -path '*/node_modules/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="find . -type d -not -path '*/.git/*' -not -path '*/node_modules/*'"

# Adds ~/.local/bin and its subdirectories to $PATH. This will help you run scripts which are in these folders
# anywhere without writing whole path.
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
