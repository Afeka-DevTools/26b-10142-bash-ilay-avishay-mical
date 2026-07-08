#!/bin/bash
#
# show_uptime.sh
# Author: Eli
#
# Description:
#   Displays how long the system has been running (uptime),
#   along with load average, in a readable format.
#
# Usage:
#   ./show_uptime.sh

set -euo pipefail

if ! command -v uptime &> /dev/null; then
    echo "'uptime' not found. Attempting to install (procps)..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y procps
    else
        echo "Error: could not find a supported package manager to install uptime."
        exit 1
    fi
fi

echo "System uptime report"
echo "---------------------"
uptime -p 2>/dev/null || uptime
echo ""
echo "Full details:"
uptime
