#!/bin/bash
#
# ascii_clock.sh
# Author: Avishai
#
# Description:
#   Displays a real-time clock on screen using ASCII art (via 'figlet'
#   if available), updating every second. Press Ctrl+C to stop.
#
# Usage:
#   ./ascii_clock.sh

set -uo pipefail

if ! command -v figlet &> /dev/null; then
    echo "'figlet' not found. Attempting to install..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y figlet
    else
        echo "Warning: could not install figlet. Falling back to plain text clock."
    fi
fi

trap 'echo -e "\nClock stopped."; exit 0' SIGINT

while true; do
    clear
    CURRENT_TIME="$(date '+%H:%M:%S')"
    if command -v figlet &> /dev/null; then
        figlet "$CURRENT_TIME"
    else
        echo "$CURRENT_TIME"
    fi
    sleep 1
done
