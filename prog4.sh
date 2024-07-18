 #!/bin/bash

# Check if the scores directory is provided
if [ -z "$1" ]; then
    echo "score directory missing"
    exit 1
fi

# Check if the provided argument is a valid directory
scores_directory="$1"
if [ ! -d "$scores_directory" ]; then
    echo "$scores_directory is not a directory"
    exit 1
fi

# Function to calculate the letter grade based on the percentage score
get_letter_grade() {
    local score=$1
    if (( score >= 93 )); then
        echo "A"
    elif (( score >= 80 )); then
        echo "B"
    elif (( score >= 65 )); then
        echo "C"
    else
        echo "D"
    fi
}

# Process each score file in the directory
for file in "$scores_directory"/*.txt; do
    if [ -f "$file" ]; then
    line_number=0  # Initialize line number counter

        # Read the file line by line
        while IFS=',' read -r -a line; do
            ((line_number++))
            if [ "$line_number" -gt 1 ]; then
                # echo "Processing file: $file"  # Debugging statement
                student_id="${line[0]}"
                scores=("${line[@]:1}")
                total_score=0

                # Calculate total score
                for ((i = 0; i < ${#scores[@]} - 1; i++)); do
                    
                    score=${scores[i]}
                    # echo "Scores $score"
                    total_score=$(( total_score + score ))
                done

                # Manually get the last score
                last_score=${scores[-1]}
                 last_score=$(echo "$last_score" | tr -d '[:space:]')
                 last_score=$((last_score))
                # echo "Last score $last_score"
                total_score=$(( total_score + last_score ))
                # echo "Total score $total_score"
                # Calculate percentage score
                percentage=$(( (total_score * 100) / (10 * (${#scores[@]} )) ))

                # echo "Percentage: $percentage"

                # Get letter grade
                letter_grade=$(get_letter_grade $percentage)

                # Display student ID and letter grade
                echo "$student_id:$letter_grade"
            fi
        done < "$file"
    fi
done



