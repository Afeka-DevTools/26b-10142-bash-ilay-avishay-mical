#!/bin/bash
#
# generate_password.sh
# Author: Avishai
#
# Description:
#   Generates a random 10-character password containing at least
#   one uppercase letter, one lowercase letter, one digit, and one symbol.
#
# Usage:
#   ./generate_password.sh

set -euo pipefail

LENGTH=10
UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
LOWER="abcdefghijklmnopqrstuvwxyz"
DIGITS="0123456789"
SYMBOLS='!@#$%^&*()_+-='

# Check for /dev/urandom which we rely on for randomness
if [[ ! -e /dev/urandom ]]; then
    echo "Error: /dev/urandom not available on this system."
    exit 1
fi

rand_char() {
    local charset="$1"
    local idx=$(( $(od -An -N2 -tu2 /dev/urandom | tr -d ' ') % ${#charset} ))
    echo -n "${charset:$idx:1}"
}

# Guarantee one of each required character type
PASSWORD="$(rand_char "$UPPER")$(rand_char "$LOWER")$(rand_char "$DIGITS")$(rand_char "$SYMBOLS")"

# Fill the rest randomly from the combined pool
ALL="${UPPER}${LOWER}${DIGITS}${SYMBOLS}"
for ((i = ${#PASSWORD}; i < LENGTH; i++)); do
    PASSWORD="${PASSWORD}$(rand_char "$ALL")"
done

# Shuffle the characters so the guaranteed ones aren't always at the start
PASSWORD="$(echo -n "$PASSWORD" | fold -w1 | shuf | tr -d '\n')"

echo "Generated password: $PASSWORD"
