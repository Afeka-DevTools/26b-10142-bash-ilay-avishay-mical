#!/bin/bash
#
# reminder.sh
# Author: Avishai
#
# Description:
#   Waits for a given number of seconds, then displays a reminder message
#   on screen (and a desktop notification, if 'notify-send' is available).
#
# Usage:
#   ./reminder.sh <seconds> "<message>"
#
# Example:
#   ./reminder.sh 60 "Take a break!"

set -euo pipefail

SECONDS_TO_WAIT="${1:-}"
MESSAGE="${2:-Reminder!}"

if [[ -z "$SECONDS_TO_WAIT" || ! "$SECONDS_TO_WAIT" =~ ^[0-9]+$ ]]; then
    echo "Usage: $0 <seconds> \"<message>\""
    exit 1
fi

echo "Reminder set for $SECONDS_TO_WAIT seconds from now: \"$MESSAGE\""
sleep "$SECONDS_TO_WAIT"

echo ""
echo "!!! REMINDER !!!"
echo "$MESSAGE"
printf '\a'  # terminal bell

if command -v notify-send &> /dev/null; then
    notify-send "Reminder" "$MESSAGE"
fi
