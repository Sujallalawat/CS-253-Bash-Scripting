#!/bin/bash

# Check if both files are given as arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_file> <output_file>"
  exit 1
fi

# Check if input file exists
if [ ! -f $1 ]; then
  echo "Input file does not exist."
  exit 1
fi

# Sort input file by goals_overall column in descending order
sort -t , -k 16nr $1 > temp_sorted.csv

# Find the unique 10 values of goals scored
unique_goals=$(awk -F , '{print $16}' temp_sorted.csv | sort -n | uniq | tail -n 10)

# Print header line to output file
echo "$(head -n 1 $1)" > $2

# Loop through unique goals and print all fields of top players with that goal count
for goal_count in $unique_goals; do
  
  count=0
  while IFS= read -r line; do
    if [ $count -lt 10 ]; then
      if [ "$(echo $line | awk -F , '{print $16}')" -eq $goal_count ]; then
        echo "$line"
        count=$((count+1))
      fi
    elif [ "$(echo $line | awk -F , '{print $16}')" -ne $goal_count ]; then
      break
    fi
  done < temp_sorted.csv
done | sort -t , -k 16nr >> $2

# Remove temporary sorted file
rm temp_sorted.csv

