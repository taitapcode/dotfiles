# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Set theme
ZSH_THEME="robbyrussell"

# Load plugins
plugins=(vi-mode zsh-autosuggestions zsh-syntax-highlighting)

# Enable change cursor on insert mode
VI_MODE_SET_CURSOR=true

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set language environment
export LANG=en_US.UTF-8

# Set default editor
export EDITOR='nvim'

# Alias
[[ -f $HOME/.config/aliasrc ]] && source $HOME/.config/aliasrc

# Set auto cd
setopt auto_cd

# Show system information
# neofetch
