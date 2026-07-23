#!/usr/bin/env bash
# rcc — compile, run, and clean up a single C++ source file.
# Usage: rcc foo.cpp [bar.cpp ...]

for file_cpp in "$@"; do
  if [[ -f "$file_cpp" && "$file_cpp" == *.cpp ]]; then
    # Strip .cpp extension to derive the output binary name
    file_out="${file_cpp%.*}"

    # Compile with C++17, optimise, enable most warnings, then run, then delete
    g++ -std=c++17 -O2 -Wall -Wextra "$file_cpp" -o "$file_out" &&
      ./"$file_out" &&
      rm -f "$file_out"
  else
    echo "$file_cpp is not cpp file"
  fi
done
