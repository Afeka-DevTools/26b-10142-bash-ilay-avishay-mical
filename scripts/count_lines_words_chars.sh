#!/bin/bash
#
# count_lines_words_chars.sh
# Author: Mical
#
# Description:
#   Counts the number of lines, words, and characters in each file
#   inside a given directory, and prints the results.
#
# Usage:
#   ./count_lines_words_chars.sh [target_directory]
#
#   [target_directory] Optional. Defaults to the current directory.
#
# Example:
#   ./count_lines_words_chars.sh ./my_folder

set -euo pipefail

TARGET_DIR="${1:-.}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

if ! command -v wc &> /dev/null; then
    echo "'wc' not found. Attempting to install (coreutils)..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y coreutils
    else
        echo "Error: could not find a supported package manager to install wc."
        exit 1
    fi
fi

printf "%-40s %10s %10s %10s\n" "FILE" "LINES" "WORDS" "CHARS"
echo "--------------------------------------------------------------------"

find "$TARGET_DIR" -maxdepth 1 -type f | while read -r FILE; do
    read -r LINES WORDS CHARS _ <<< "$(wc -l -w -c "$FILE")"
    printf "%-40s %10s %10s %10s\n" "$(basename "$FILE")" "$LINES" "$WORDS" "$CHARS"
done
