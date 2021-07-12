# Set options
setopt autocd menucomplete
zle_highlight=('paste:none')

# Useful functions
source "$ZDOTDIR/zsh-fucntions"

# Add some files
add_file "zsh-alias"
add_file "zsh-theme"

# Plugins
add_plugin "zsh-autosuggestions"
add_plugin "zsh-syntax-highlighting"
add_plugin "vi-mode"

# Set cursor vim
VI_MODE_SET_CURSOR=true

# History
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
