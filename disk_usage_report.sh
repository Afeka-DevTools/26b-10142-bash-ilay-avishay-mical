#!/bin/bash
#
# disk_usage_report.sh
# Author: Eli
#
# Description:
#   Displays disk usage for each immediate subfolder of a given directory,
#   sorted from largest to smallest.
#
# Usage:
#   ./disk_usage_report.sh [target_directory]
#
#   [target_directory] Optional. Defaults to the current directory.
#
# Example:
#   ./disk_usage_report.sh /home/user

set -euo pipefail

TARGET_DIR="${1:-.}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

if ! command -v du &> /dev/null; then
    echo "'du' not found. Attempting to install (coreutils)..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y coreutils
    else
        echo "Error: could not find a supported package manager to install du."
        exit 1
    fi
fi

echo "Disk usage for subfolders of '$TARGET_DIR':"
echo "--------------------------------------------"
du -h --max-depth=1 "$TARGET_DIR" 2>/dev/null | sort -rh
