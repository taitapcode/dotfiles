#!/bin/bash

# Dependencies: xbacklight

backlight()
{
  backlight="$(xbacklight | awk '{print int($1)}')"

  if [[ "$backlight" -gt 0 ]] && [[ "$backlight" -le 25 ]]; then
    printf " %s%%" "$backlight"
  elif [[ "$backlight" -gt 25 ]] && [[ "$backlight" -le 50 ]]; then
    printf " %s%%" "$backlight"
  elif [[ "$backlight" -gt 50 ]] && [[ "$backlight" -le 75 ]]; then
    printf " %s%%" "$backlight"
  else
    printf " %s%%" "$backlight"
  fi

  printf "%s" "$SEP"
}
