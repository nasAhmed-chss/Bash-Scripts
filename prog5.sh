#!/bin/bash

# Check if both input file and dictionary are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "input file and dictionary missing"
    exit 1
fi

# Check if the provided file exists
if [ ! -f "$1" ]; then
    echo "$1 is not a file"
    exit 1
fi

# Check if the provided dictionary exists
if [ ! -f "$2" ]; then
    echo "$2 is not a file"
    exit 1
fi

# Read each line from the input file
while IFS= read -r line; do
    # Read each word from the line
    for word in $line; do
        
        if [ ${#word} -eq 4 ]; then
            # echo "Word: $word"
            last_char="${word: -1}"  # Get the last character of the word
            # echo "Last character: $last_char"
            
            # Check if the word is present in the dictionary
        if [[ "$last_char" =~ [[:alpha:]] ]] && ! grep -Fxq "$word" "$2"; then
            echo "$word"
        fi
        fi
    done
done < "$1"

