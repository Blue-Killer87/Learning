#!/bin/bash

numbers=(12 5 17 9 1 20 4 8 13 2 19 11 7 3 10 15 18 6 14 16)

quicksort() {
    local array=("$@")
    local pivot
    local -a left right sorted

    [[ ${#array[@]} -le 1 ]] && echo "${array[@]}" && return

    pivot=${array[0]}
    for (( i=1; i<${#array[@]}; i++ )); do
        if (( ${array[i]} < pivot )); then
            left+=("${array[i]}")
        else
            right+=("${array[i]}")
        fi
    done

    sorted=($(quicksort "${left[@]}"))
    sorted+=("$pivot")
    sorted+=($(quicksort "${right[@]}"))

    echo "${sorted[@]}"

}


echo "Input: ${numbers[@]}"
sorted_numbers=($(quicksort "${numbers[@]}"))
echo "Output: ${sorted_numbers[@]}"


