#!/bin/bash

numbers=(12 5 17 9 1 20 4 8 13 2 19 11 7 3 10 15 18 6 14 16)

quicksort_iterative() {
    local arr=("$@")
    local stack=()
    local result=()
    local -a left right temp
    local pivot

    stack+=("${arr[*]}")

    while ((${#stack[@]} > 0)); do
        temp=(${stack[-1]})
        unset 'stack[-1]'

        if ((${#temp[@]} <= 1)); then
            result+=("${temp[@]}")
            continue
        fi

        pivot=${temp[0]}
        left=()
        right=()

        for ((i=1; i<${#temp[@]}; i++)); do
            if (( temp[i] < pivot )); then
                left+=("${temp[i]}")
            else
                right+=("${temp[i]}")
            fi
        done

        [[ ${#right[@]} -gt 0 ]] && stack+=("${right[*]}")
        stack+=("$pivot")
        [[ ${#left[@]} -gt 0 ]] && stack+=("${left[*]}")
    done

    echo "${result[@]}"
}

echo "Input: ${numbers[@]}"
sorted_numbers=($(quicksort_iterative "${numbers[@]}"))
echo "Output: ${sorted_numbers[@]}"

