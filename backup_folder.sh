#!/bin/bash
#
# backup_folder.sh
# Author: Eli
#
# Description:
#   Backs up (archives + compresses) the contents of a given folder
#   into a .tar.gz file, saved with a timestamp in its name.
#
# Usage:
#   ./backup_folder.sh <folder_to_backup> [destination_folder]
#
#   <folder_to_backup>   Path to the folder you want to back up (required)
#   [destination_folder] Where to save the .tar.gz file (optional, defaults to current directory)
#
# Example:
#   ./backup_folder.sh ~/Documents/project ~/Backups

set -euo pipefail

SOURCE_DIR="${1:-}"
DEST_DIR="${2:-.}"

if [[ -z "$SOURCE_DIR" ]]; then
    echo "Usage: $0 <folder_to_backup> [destination_folder]"
    exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: '$SOURCE_DIR' is not a valid directory."
    exit 1
fi

# tar is a core utility and should already be installed on virtually every Linux system,
# but we check anyway and try to install it if missing (Debian/Ubuntu assumed).
if ! command -v tar &> /dev/null; then
    echo "'tar' not found. Attempting to install..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y tar
    else
        echo "Error: could not find a supported package manager to install tar."
        exit 1
    fi
fi

mkdir -p "$DEST_DIR"

FOLDER_NAME="$(basename "$SOURCE_DIR")"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
ARCHIVE_NAME="${FOLDER_NAME}_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${DEST_DIR%/}/${ARCHIVE_NAME}"

echo "Backing up '$SOURCE_DIR' to '$ARCHIVE_PATH'..."
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE_DIR")" "$FOLDER_NAME"

echo "Backup complete: $ARCHIVE_PATH"
