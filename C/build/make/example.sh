#!/bin/bash

echo "1 2 3 4 5 6 7 8 9 10" | LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./reverse
