#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo “data file or output file not found”
    exit 1
fi

data_file=$1
output_file=$2

# Check if the data file exists
if [ ! -f "$data_file" ]; then
    echo “data file or output file not found”
    exit 1
fi

# Check if the output file exists, if not create it
touch "$output_file"

# Clear the output file if it exists
> "$output_file"

compute_column_sum() {
    local file="$1"
    local output="$2"
    awk -F'[;,:]' '
        {
            # Update max_fields if the number of fields encountered is greater
            if (NF > max_fields) {
                max_fields = NF
            }
            for (i = 1; i <= NF; i++) {
                sum[i] += $i
            }
        }
        END {
            for (i = 1; i <= max_fields; i++) {  # Start from second column
                print "Col " i " : " sum[i] >> output
            }
        }
    ' "$file" output="$output"
}


# Compute the sum of each column and write to the output file
compute_column_sum "$data_file" "$output_file"
