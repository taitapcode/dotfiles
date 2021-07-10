# Export
export ZSH=$HOME/.oh-my-zsh           # Path to your oh-my-zsh installation.
export LANG=en_US.UTF-8               # Set language environment
export EDITOR="nvim"                  # Set default editor
export BROWSER="chromium"             # Set default browser
export PATH="$PATH:$HOME/.local/bin"  # This will help you run scripts which are in these folders.

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Set theme
ZSH_THEME="omz"

# Set auto cd
setopt auto_cd

# Alias
[[ -f $ZSH/zsh-alias ]] && source $ZSH/zsh-alias

# Load plugins
plugins=(vi-mode zsh-syntax-highlighting zsh-autosuggestions)

# Enable change cursor on insert mode
VI_MODE_SET_CURSOR=true

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
