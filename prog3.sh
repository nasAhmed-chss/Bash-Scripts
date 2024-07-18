#!/bin/bash

# Check if data file is provided
if [ -z "$1" ]; then
    echo "missing data file"
    exit 1
fi

# Read data file and weights
data_file="$1"
weights=("${@:2}")

# Read header to determine number of parts
IFS=',' read -r -a header < "$data_file"
num_parts=$(( ${#header[@]} - 1 ))


#  If no weights provided, assign 1 as weight for each part
# If no weights provided, assign 1 as weight for each part
if [ ${#weights[@]} -eq 0 ]; then
    weights=()
    for ((i=0; i<num_parts; i++)); do
        weights+=(1)
    done
else
    # Check if the number of provided weights is less than the number of parts
    num_weights=${#weights[@]}
    if [ "$num_weights" -lt "$num_parts" ]; then
        # Add default weights of 1 for the remaining parts
        for ((i=num_weights; i<num_parts; i++)); do
            weights+=(1)
        done
    fi
fi





# Calculate weighted average for each student
total_weighted_sum=0
total_weights_sum=0
weighted_average=0
num_students=0

while IFS=',' read -r -a line; do
    student_id="${line[0]}"
    scores=("${line[@]:1}")
    weighted_sum=0
    weights_sum=0
 
    # echo "Number of parts: $num_parts"
    # echo "Weights array length: ${#weights[@]}"
    # echo "Scores array length: ${#scores[@]}"

    for (( i=0; i<num_parts-1; i++ )); do
        weight=${weights[$i]}
        score=${scores[$i]}
        # echo "Weight: $weight"
        # echo "Score: $score"
        inter=$(( weight * score ))
        weighted_sum=$(( weighted_sum + inter))
         weights_sum=$(( weights_sum + weight ))

        # echo "Total Weighted Sum: $weighted_sum"
        #  echo "Total Weight Sum: $weights_sum"

    done
    # Process the last score manually
    last_weight=${weights[-1]}  # Get the last weight
    # Process the last score manually
    last_index=$(( ${#scores[@]} - 1 ))  # Calculate the index of the last score
    last_score=${scores[last_index]}    # Get the last score
    last_score=$(echo "$last_score" | tr -d '[:space:]')
    last_score=$((last_score))

    # echo "
    
    
    
    # "
    # echo "Last Weight:  $last_weight"
    # echo "Last Score:  $last_score"
    


    inter=$(( last_weight * last_score ))  # Multiply last weight with last score
    weighted_sum=$(( weighted_sum + inter ))  # Add to weighted sum
    weights_sum=$(( weights_sum + last_weight ))  # Increment weight sum




    # echo "Student $student_id - Weighted Sum: $weighted_sum, Weight Sum: $weights_sum"

    # Accumulate weighted average for all students
    total_weighted_sum=$(( total_weighted_sum + weighted_sum ))
    total_weights_sum=$(( total_weights_sum + weights_sum ))
    # Calculate the weighted average with floating-point division
   # Calculate the weighted average with floating-point division
weighted_average=$(awk "BEGIN { printf \"%.2f\", $weighted_average + $total_weighted_sum / $total_weights_sum }")

    # echo " Weighted Average: $weighted_average"
     # Increment number of students
    ((num_students++))



done < <(tail -n +2 "$data_file")



# echo "Total Weighted Sum: $total_weighted_sum"
# echo "Total Weight Sum: $total_weights_sum"
# echo "Number of students processed: $num_students"


# Calculate overall weighted average
if [ "$num_students" -eq 0 ]; then
    overall_weighted_average=0
else
    overall_weighted_average=$(awk "BEGIN { result = $weighted_average / $num_students; printf \"%.0f\", int(result) }")


fi

# Display overall weighted average
echo "Overall Weighted Average: $overall_weighted_average"
            

