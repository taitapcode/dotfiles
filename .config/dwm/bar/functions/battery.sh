#!/bin/bash

battery()
{
  # Get power status
  POWER="$(cat /sys/class/power_supply/BAT1/capacity)"
  STATUS="$(cat /sys/class/power_supply/BAT1/status)"

  # Print output
  if [[ "$STATUS" = "Charging" ]]; then
    if [[ "$POWER" -gt 0 ]] && [[ "$POWER" -le 20 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "20" ]] && [[ "$POWER" -le 30 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "30" ]] && [[ "$POWER" -le 40 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "40" ]] && [[ "$POWER" -le 60 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "60" ]] && [[ "$POWER" -le 80 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "80" ]] && [[ "$POWER" -le 97 ]]; then
      printf " %s%%" "$POWER"
    else
      printf " %s%%" "$POWER" 
    fi
  else
    if [[ "$POWER" -gt 0 ]] && [[ "$POWER" -le 10 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "10" ]] && [[ "$POWER" -le 20 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "20" ]] && [[ "$POWER" -le 30 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "30" ]] && [[ "$POWER" -le 40 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "40" ]] && [[ "$POWER" -le 50 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "50" ]] && [[ "$POWER" -le 60 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "60" ]] && [[ "$POWER" -le 70 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "70" ]] && [[ "$POWER" -le 80 ]]; then
      printf " %s%%" "$POWER"
    elif [[ "$POWER" -gt "80" ]] && [[ "$POWER" -le 95 ]]; then
      printf " %s%%" "$POWER"
    else
      printf " %s%%" "$POWER"
    fi
  fi

  printf "%s" "$SEP"
}