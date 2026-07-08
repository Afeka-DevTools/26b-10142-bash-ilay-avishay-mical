#!/bin/bash
#
# count_files_by_extension.sh
# Author: Mical
#
# Description:
#   Counts the number of files for each file extension found within
#   a given directory (recursively), and prints a summary sorted
#   from most common to least common.
#
# Usage:
#   ./count_files_by_extension.sh [target_directory]
#
#   [target_directory] Optional. Defaults to the current directory.
#
# Example:
#   ./count_files_by_extension.sh ./my_project

set -euo pipefail

TARGET_DIR="${1:-.}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

echo "File counts by extension in '$TARGET_DIR':"
echo "----------------------------------------------"

find "$TARGET_DIR" -type f | sed -n 's/.*\.\([a-zA-Z0-9]*\)$/\1/p' | \
    sort | uniq -c | sort -rn | awk '{printf "%-15s %s\n", $2, $1}'

# Report files with no extension separately
NO_EXT_COUNT=$(find "$TARGET_DIR" -type f ! -name "*.*" | wc -l)
if (( NO_EXT_COUNT > 0 )); then
    echo "(no extension)  $NO_EXT_COUNT"
fi
