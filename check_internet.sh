#!/bin/bash
#
# check_internet.sh
# Author: Eli
#
# Description:
#   Checks internet connectivity by pinging a reliable host,
#   and prints a timestamped log line to the screen (and optionally to a log file).
#
# Usage:
#   ./check_internet.sh [log_file]
#
#   [log_file] Optional path to also append the result to a log file.
#
# Example:
#   ./check_internet.sh internet_check.log

set -uo pipefail

LOG_FILE="${1:-}"
HOST="8.8.8.8"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

if ! command -v ping &> /dev/null; then
    echo "'ping' not found. Attempting to install..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y iputils-ping
    else
        echo "Error: could not find a supported package manager to install ping."
        exit 1
    fi
fi

if ping -c 1 -W 2 "$HOST" &> /dev/null; then
    STATUS="ONLINE - internet connection is working"
else
    STATUS="OFFLINE - no internet connection detected"
fi

LOG_LINE="[$TIMESTAMP] $STATUS"
echo "$LOG_LINE"

if [[ -n "$LOG_FILE" ]]; then
    echo "$LOG_LINE" >> "$LOG_FILE"
fi
