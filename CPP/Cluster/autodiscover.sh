#!/bin/bash

# Autodiscover searches the local network of a cluster and lists located devices together with their IP addresses.

CONF_FILE="/bin/node.conf"
PORT=1933

# Detect subnet dynamically (assumes interface is up and has a private IP)
SUBNET=$(ip -4 addr show | grep -oP 'inet \K192\.168\.\d+' | head -n1)
if [ -z "$SUBNET" ]; then
    echo "Could not detect local subnet. Please set manually."
    exit 1
fi

# If --list option is passed
if [[ "$1" == "--list" ]]; then
    echo "=== Node List ==="
    grep -v '^#' "$CONF_FILE"
    exit 0
fi

# Ensure CONF_FILE exists
if [ ! -f "$CONF_FILE" ]; then
    echo "#LAST_ID=0" > "$CONF_FILE"
fi

# Get last ID from file
LAST_ID=$(grep '^#LAST_ID=' "$CONF_FILE" | cut -d= -f2)
if [ -z "$LAST_ID" ]; then
    LAST_ID=0
fi

echo "Scanning subnet: $SUBNET.0/24 on port $PORT..."

# Loop over possible IPs
for i in {1..254}; do
    IP="$SUBNET.$i"
    echo -n "Checking $IP... "

    # Check if port is open (connects in <1s)
    timeout 1 bash -c "echo > /dev/tcp/$IP/$PORT" 2>/dev/null
    if [ $? -eq 0 ]; then
        # Check if already in list
        if grep -q "$IP" "$CONF_FILE"; then
            echo "Already added."
        else
            ((LAST_ID++))
            echo "Found! Adding as slave$LAST_ID"
            echo "slave$LAST_ID=$IP" >> "$CONF_FILE"
            # Update LAST_ID in file
            sed -i "s/^#LAST_ID=.*/#LAST_ID=$LAST_ID/" "$CONF_FILE"
        fi
    else
        echo "No response."
    fi
done

echo "Scan complete."
