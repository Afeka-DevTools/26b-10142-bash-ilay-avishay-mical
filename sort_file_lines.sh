#!/bin/bash
#
# sort_file_lines.sh
# Author: Mical
#
# Description:
#   Sorts the lines of a given text file alphabetically and prints
#   the result (optionally saving it to an output file).
#
# Usage:
#   ./sort_file_lines.sh <input_file> [output_file]
#
# Example:
#   ./sort_file_lines.sh names.txt sorted_names.txt

set -euo pipefail

INPUT_FILE="${1:-}"
OUTPUT_FILE="${2:-}"

if [[ -z "$INPUT_FILE" ]]; then
    echo "Usage: $0 <input_file> [output_file]"
    exit 1
fi

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: '$INPUT_FILE' is not a valid file."
    exit 1
fi

if [[ -n "$OUTPUT_FILE" ]]; then
    sort "$INPUT_FILE" > "$OUTPUT_FILE"
    echo "Sorted lines written to '$OUTPUT_FILE'."
else
    sort "$INPUT_FILE"
fi
