#!/usr/bin/env bash

for file_cpp in "$@"; do
  if [[ -f "$file_cpp" && "$file_cpp" == *.cpp ]]; then
    file_out="${file_cpp%.*}"
    g++ -std=c++17 -O2 -Wall -Wextra "$file_cpp" -o "$file_out" &&
      ./"$file_out" &&
      rm -f "$file_out"
  else
    echo "$file_cpp is not cpp file"
  fi
done
