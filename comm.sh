#!/bin/bash

# Check if both files are provided as input
if [ "$#" -ne 2 ]; then
    echo "Usage: comm.sh file1 file2"
    exit 1
fi

# Check if file1 exists
if [ ! -f "$1" ]; then
    echo "Error: $1 does not exist"
    exit 1
fi

# Check if file2 exists
if [ ! -f "$2" ]; then
    echo "Error: $2 does not exist"
    exit 1
fi

# Redirect output to a file named "output.txt"
exec > output2.txt

# Loop through each line of file1
while IFS= read -r line1
do
    # Skip empty lines
    if [[ -z "$line1" ]]; then
        continue
    fi
    
    # Loop through each line of file2
    while IFS= read -r line2
    do
        # Skip empty lines
        if [[ -z "$line2" ]]; then
            continue
        fi
        
        # Compare the lines and print if they match
        if [ "$line1" = "$line2" ]; then
            echo "$line1"
        fi
        
    done < "$2"
    
done < "$1"

