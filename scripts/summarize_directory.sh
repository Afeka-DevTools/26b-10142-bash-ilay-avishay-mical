#!/bin/bash
#
# summarize_directory.sh
# Author: Mical
#
# Description:
#   Summarizes the number of files, folders, and symbolic links
#   inside a given directory.
#
# Usage:
#   ./summarize_directory.sh [target_directory]
#
#   [target_directory] Optional. Defaults to the current directory.
#
# Example:
#   ./summarize_directory.sh /home/user/project

set -euo pipefail

TARGET_DIR="${1:-.}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

FILE_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)
DIR_COUNT=$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
LINK_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type l | wc -l)

echo "Summary for '$TARGET_DIR':"
echo "----------------------------"
echo "Files:        $FILE_COUNT"
echo "Directories:  $DIR_COUNT"
echo "Symlinks:     $LINK_COUNT"
