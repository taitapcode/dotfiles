# Navigation
# alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'
alias 3..='cd ../../..'

# Ls (Eza)
alias ls='eza --icons --group-directories-first'
alias ll='ls --header --long'
alias la='ll --all'
alias lt='ll --tree --level=2'
alias lta='lt --all'

# Cat (Bat)
alias cat='bat'

# Cp
alias cp='cp -i'
alias cf='cp -r'

# Rm
alias rf='rm -rf'

# Grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'
alias gst='git status'
alias lgit='lazygit'

# Others
alias pm='sudo pacman'
alias cl='clear'
alias lg='lazygit'
alias mux='tmuxinator'
