#!/bin/bash
#
# find_recent_files.sh
# Author: Mical
#
# Description:
#   Finds all files that were modified within the last N days,
#   inside a given directory (recursively).
#
# Usage:
#   ./find_recent_files.sh <target_directory> <N>
#
# Example:
#   ./find_recent_files.sh ~/project 7

set -euo pipefail

TARGET_DIR="${1:-}"
DAYS="${2:-}"

if [[ -z "$TARGET_DIR" || -z "$DAYS" ]]; then
    echo "Usage: $0 <target_directory> <N_days>"
    exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

if [[ ! "$DAYS" =~ ^[0-9]+$ ]]; then
    echo "Error: N must be a positive integer."
    exit 1
fi

echo "Files modified in the last $DAYS day(s) in '$TARGET_DIR':"
echo "------------------------------------------------------------"
find "$TARGET_DIR" -type f -mtime "-$DAYS"
