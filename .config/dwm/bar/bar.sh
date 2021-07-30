#!/bin/bash

# Get script directory
LOCATE=$(readlink -f "$0")
DIR=$(dirname "$LOCATE")

# Import functions
. "$DIR/functions/date_time.sh"
. "$DIR/functions/resources.sh"
. "$DIR/functions/volume.sh"
. "$DIR/functions/covid.sh"
. "$DIR/functions/backlight.sh"
. "$DIR/functions/battery.sh"

# SEP
export SEP=" | "

# While loop
while true
do
  # Add bar functions
  bar=""
  bar="$bar$(covid)"
  bar="$bar$(resources)"
  bar="$bar$(backlight)"
  bar="$bar$(volume)"
  bar="$bar$(battery)"
  bar="$bar$(date_time)"

  # Set bar functions
  xsetroot -name "$bar"
  sleep 0.1
done
