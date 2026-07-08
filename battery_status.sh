#!/bin/bash
#
# battery_status.sh
# Author: Eli
#
# Description:
#   Displays the current battery status (charge percentage and charging state)
#   of the computer, using upower if available, falling back to /sys.
#
# Usage:
#   ./battery_status.sh

set -uo pipefail

if command -v upower &> /dev/null; then
    BATTERY_PATH=$(upower -e | grep -i 'BAT' | head -n 1)
    if [[ -n "$BATTERY_PATH" ]]; then
        upower -i "$BATTERY_PATH" | grep -E "state|percentage|time to"
        exit 0
    fi
fi

# Fallback: try installing upower
if ! command -v upower &> /dev/null; then
    echo "'upower' not found. Attempting to install..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y upower
        BATTERY_PATH=$(upower -e | grep -i 'BAT' | head -n 1)
        if [[ -n "$BATTERY_PATH" ]]; then
            upower -i "$BATTERY_PATH" | grep -E "state|percentage|time to"
            exit 0
        fi
    fi
fi

# Fallback: read directly from /sys (works on most Linux laptops)
BAT_DIR=$(find /sys/class/power_supply -maxdepth 1 -iname 'BAT*' | head -n 1)
if [[ -n "$BAT_DIR" && -f "$BAT_DIR/capacity" ]]; then
    CAPACITY=$(cat "$BAT_DIR/capacity")
    STATUS=$(cat "$BAT_DIR/status")
    echo "Battery capacity: ${CAPACITY}%"
    echo "Status: $STATUS"
else
    echo "No battery found. This may be a desktop machine or a VM without battery info."
fi
