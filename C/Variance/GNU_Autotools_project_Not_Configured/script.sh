#!/bin/bash

SECONDS=0

# If wrongs arguments were used, don't even start, return help
if [ $# -ne 3 ]; then
    echo "Usage: $0 <file.txt> <interval N> <statistics: mean|var>"
    exit 1
fi

# Correct arguments detected, load them into variables
TXTFILE="$1"
BASENAME="${TXTFILE%.txt}"
DATFILE="${BASENAME}.dat"
N="$2"
STAT="$3"

# Check for .dat file
if [ ! -f "$DATFILE" ]; then
    echo "Missing the .dat file: $DATFILE"
    exit 1
fi

# Try to find values in header of txt file (first 500 lines)
get_value() {
    local key="$1"
    local value=$(head -n 500 "$TXTFILE" | grep -i -w "$key" | sed -E 's/.*:[[:space:]]*([0-9.]+).*/\1/')
    if [ -z "$value" ]; then
        value=$(grep -i -w "$key" "$TXTFILE" | sed -E 's/.*:[[:space:]]*([0-9.]+).*/\1/')
    fi
    echo "$value"
}
# Get Values from txt file
PREGAIN=$(get_value "Pre-Gain")
GAIN=$(get_value "Gain")
FREQ=$(head -n 500 "$TXTFILE" | grep -i "Sampling Freq\." | grep -v "Nominator" | sed -E 's/.*:[[:space:]]*([0-9.]+).*/\1/')
if [ -z "$FREQ" ]; then
    FREQ=$(grep -i "Sampling Freq\." "$TXTFILE" | grep -v "Nominator" | sed -E 's/.*:[[:space:]]*([0-9.]+).*/\1/')
fi

TOTALGAIN=$(awk -v g="$GAIN" -v p="$PREGAIN" 'BEGIN { printf "%.2f", (g + p)}')
# echo "Total Gain: $TOTALGAIN"     # For debug

DELTA_T=$(awk -v n="$N" -v f="$FREQ" 'BEGIN { printf "%.8f", n / f }')

# Storing the whole gnuplot command into a string (helps with expansions)
PLOT_CMD="./runstats.sh $N $STAT $TOTALGAIN $DATFILE $DELTA_T"
#echo $PLOT_CMD     # For debug

# GnuPlot
gnuplot -persist <<EOF
set terminal png enhanced notransparent nointerlace truecolor font "Liberation, 20" size 2000,1400
set output "Stats_$STAT\_output.png"
set xlabel "Time (s)"
set ylabel "$STAT"
set grid
set autoscale fix
set format y "%.0t×10^{%T}"
set format x "%.1f"
set xtics add ("0" 0)
set ytics add ("0" 0)

plot "< $PLOT_CMD" using 1:2 with lines title "$STAT  1:$N"
EOF

echo "Job finished in $SECONDS seconds"