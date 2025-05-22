#!/bin/bash

# Make sure correct arguments were passed 
if [ $# -ne 5 ]; then
  echo "Usage: $0 <N> <stat> <totalgain> <datfile> <delta_t>" >&2
  exit 1
fi

# Load arguments into variables
N="$1"
STAT="$2"
TOTALGAIN="$3"
DATFILE="$4"
DELTA_T="$5"

# Launch the stats program and append time to the output -> output it into gnuplot
./src/stats "$N" "$STAT" "$TOTALGAIN" < "$DATFILE" \
  | awk -v dt="$DELTA_T" 'NF==1 && $1+0==$1 { printf "%.10f %.10f\n", NR*dt, $1 }'
