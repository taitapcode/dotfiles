#!/bin/bash

covid()
{
  # Set your country name
  # Note: Don't capitalize first letter.
  COUNTRY="vietnam"

  # Set data locate
  DATA_LOCATE="/tmp/covid.log"

  # Install data from https://corona.lmao.ninja/v2/countries/ to /tmp/covid.log
  if ! [[ -f "$DATA_LOCATE" ]] || [[ "$(cat $DATA_LOCATE)" == "" ]]; then
    curl -s "https://corona.lmao.ninja/v2/countries/$COUNTRY" | \
    awk -F',' '{ for (i = 1; i < 30; ++i) print $i;}' > "$DATA_LOCATE"
  fi

  # Get data
  GET_DATA="$(cat $DATA_LOCATE)"
  DATA=($GET_DATA)

  for i in "${!DATA[@]}"
  do
    [[ "${DATA[i]}" == *'"cases":'* ]]             && CASES="${DATA[i]#*:}"
    [[ "${DATA[i]}" == *'"todayCases":'* ]]        && TODAY_CASES="${DATA[i]#*:}"
    [[ "${DATA[i]}" == *'"deaths":'* ]]            && DEATHS="${DATA[i]#*:}"
    [[ "${DATA[i]}" == *'"todayDeaths":'* ]]       && TODAY_DEATHS="${DATA[i]#*:}"
    [[ "${DATA[i]}" == *'"recovered":'* ]]         && RECOVERED="${DATA[i]#*:}"
    [[ "${DATA[i]}" == *'"todayRecovered":'* ]]    && TODAY_RECOVERED="${DATA[i]#*:}"
  done

  # Print output
  printf " %s(+%s),ﮊ %s(+%s), %s(+%s)" "$CASES" "$TODAY_CASES" "$DEATHS" "$TODAY_DEATHS" "$RECOVERED" "$TODAY_RECOVERED"
  printf "%s" "$SEP"
}
