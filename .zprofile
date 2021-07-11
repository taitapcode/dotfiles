# This will help you run scripts which are in these folders.
export PATH="$PATH:$HOME/.local/bin"

# Export ibus module
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Run startx
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
fi
