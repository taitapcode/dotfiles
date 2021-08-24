# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Colors
autoload -Uz colors && colors

# Useful functions
source "$ZDOTDIR/zsh-functions"

# Add some files
add_file "zsh-aliases"
add_file "zsh-theme"
add_file "zsh-vim-mode"

# History
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=5000
HISTSIZE=5000

# Plugins
add_plugin "zsh-autosuggestions"
add_plugin "zsh-syntax-highlighting"

# Zsh autosuggestions
# Set Alt+Tab to choose autosuggestion
bindkey '^[\t' autosuggest-accept
