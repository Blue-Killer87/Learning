#!/bin/bash

numbers=("fbs" "esfb" "avbg" "dgdvc" "czrf")
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


