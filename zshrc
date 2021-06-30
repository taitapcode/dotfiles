# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Set theme
ZSH_THEME="duellj"

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

# User alias
# ls
alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -A'
alias lm='ls -m'
alias lr='ls -R'
alias lg='ls -l --group-directories-first'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

# Other
alias nvimconfig="cd ~/.config/nvim && nvim"
alias cl="clear"
alias rf="rm -rf"

# Set auto cd
setopt auto_cd

# Show system information
neofetch
