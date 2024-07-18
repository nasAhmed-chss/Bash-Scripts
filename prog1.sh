#!/bin/bash

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
    echo "src and dest dirs missing"
    exit 1
fi

src_dir=$1
dest_dir=$2

# Check if source directory exists
if [ ! -d "$src_dir" ]; then
    echo "$src_dir not found"
    exit 0
fi

# Check if destination directory exists, if not create it
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

# Function to move files recursively while maintaining directory structure
move_files() {
    src_dir="$1"
    dest_dir="$2"

    for file in "$src_dir"/*; do
        if [ -d "$file" ]; then
         # If the current item is a directory, create the corresponding directory in the destination
            mkdir -p "$dest_dir/$(basename "$file")"
            # Recursively call move_files for the subdirectory
            move_files "$file" "$dest_dir/$(basename "$file")"

        elif [ -f "$file" ]; then

            if [ "${file##*.}" == "c" ]; then
              
                if [ "$(ls -l "$src_dir" |wc -l)" -gt 4 ]; then
                    echo "File: $file"
                    echo -n "Moving files from $src_dir. Do you want to proceed? (y/n): "
                    read -r choice
                    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                        cp "$file" "$dest_dir"
                    fi
                else
                    cp "$file" "$dest_dir"
                fi
            fi
        fi
    done
}

# Move files recursively
move_files "$src_dir" "$dest_dir"

