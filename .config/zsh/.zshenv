# Default program
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="chromium"

# Adds ~/.local/bin and its subdirectories to $PATH. This will help you run scripts which are in these folders
# anywhere without writing whole path.
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

# Some default config directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_CONFIG_HOME/X11/Xauthority"  # Warning: This line will break some DMs

# Ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
