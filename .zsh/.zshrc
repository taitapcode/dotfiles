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

# # Add some files
add_file "zsh-alias"
add_file "zsh-theme"

# Plugins
add_plugin "zsh-autosuggestions"
add_plugin "zsh-syntax-highlighting"
add_plugin "zsh-vim-mode"

# Set cursor on vim mode
MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

# History
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
