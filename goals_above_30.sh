#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 file1 file2"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: $1 does not exist"
  exit 1
fi
if [ -f "$2" ]; then
    rm "$2"
fi

awk -F, '{if($2>30 && $16>=1) { print } }' "$1" >> "$2"

