#!/bin/bash

date_time()
{
  # Get date info
  date="$(date "+%A %d/%m/%Y")"
  time="$(date "+%T")"

  printf " %s  %s" "$date" "$time"
}
