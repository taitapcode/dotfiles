#!/bin/sh
# -------------------------------------------------------------------

[[ -f $HOME/.xprofile ]] && source $HOME/.xprofile &

# Exec 
exec dwm
