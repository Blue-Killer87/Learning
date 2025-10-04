#!/bin/bash

CONFIG="nodes.conf"      # path to config file (contains names and IPs of nodes [can be automated by autodiscovery script])
EXECUTABLE="./mainnode"  # path to compiled C++ client

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <nickname> <command>"
    exit 1
fi

NICKNAME="$1"
shift
COMMAND="$*"

IP=$(grep "^$NICKNAME=" "$CONFIG" | cut -d '=' -f2)

if [ -z "$IP" ]; then
    echo "Node nickname '$NICKNAME' not found in config."
    exit 1
fi

$EXECUTABLE "$IP" "$COMMAND"
