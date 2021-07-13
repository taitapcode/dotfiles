# Set options
setopt auto_cd

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

# Plugins
add_plugin "zsh-autosuggestions"
add_plugin "zsh-syntax-highlighting"

# History
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
