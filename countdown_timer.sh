#!/bin/bash
#
# countdown_timer.sh
# Author: Avishai
#
# Description:
#   Counts down from a given duration (HH:MM:SS) and displays the
#   remaining time updating every second, then announces when time is up.
#
# Usage:
#   ./countdown_timer.sh <HH:MM:SS>
#
# Example:
#   ./countdown_timer.sh 00:01:30

set -euo pipefail

INPUT="${1:-}"

if [[ -z "$INPUT" ]]; then
    echo "Usage: $0 <HH:MM:SS>"
    exit 1
fi

if [[ ! "$INPUT" =~ ^([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})$ ]]; then
    echo "Error: time must be in HH:MM:SS format (e.g. 00:01:30)."
    exit 1
fi

HOURS="${BASH_REMATCH[1]}"
MINUTES="${BASH_REMATCH[2]}"
SECONDS="${BASH_REMATCH[3]}"

TOTAL_SECONDS=$((10#$HOURS * 3600 + 10#$MINUTES * 60 + 10#$SECONDS))

if (( TOTAL_SECONDS <= 0 )); then
    echo "Error: duration must be greater than zero."
    exit 1
fi

echo "Starting countdown from $INPUT..."

while (( TOTAL_SECONDS > 0 )); do
    H=$((TOTAL_SECONDS / 3600))
    M=$(((TOTAL_SECONDS % 3600) / 60))
    S=$((TOTAL_SECONDS % 60))
    printf "\rTime remaining: %02d:%02d:%02d" "$H" "$M" "$S"
    sleep 1
    ((TOTAL_SECONDS--))
done

printf "\rTime remaining: 00:00:00\n"
echo "Time's up!"
