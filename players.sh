#!/bin/bash

if [ ! -f "$1" ]; then
  echo "Input file does not exist"
  exit 1
fi

if [ -f "$2" ]; then
  rm "$2"
  touch "$2"
fi

cut -d ',' -f 1,7,12,16 "$1" > temp.csv

awk 'BEGIN {FS=OFS=","} {temp=$2; $2=$3; $3=temp; print}' temp.csv > tempo.csv

read -r line < tempo.csv
echo "$line" > "$2"

tail -n +2 tempo.csv | awk 'BEGIN {FS=OFS=","} {
  if ($3 == "Goalkeeper") print $0,4
  else if ($3 == "Defender") print $0,3
  else if ($3 == "Midfielder") print $0,2
  else if ($3 == "Forward") print $0,1
}' tempo.csv > players.csv

sort -t ',' -k 4,4rn -k 5,5rn players.csv > bash.csv

cut -d ',' -f 1,2,3,4 bash.csv >> "$2"

rm temp.csv
rm players.csv
rm bash.csv
rm tempo.csv

