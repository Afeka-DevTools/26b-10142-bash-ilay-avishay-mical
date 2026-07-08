#!/bin/bash
#
# show_env_vars.sh
# Author: Avishai
#
# Description:
#   Displays a curated list of important environment variables
#   (PATH, HOME, USER, SHELL, LANG, PWD, etc.) in a readable format.
#
# Usage:
#   ./show_env_vars.sh

set -euo pipefail

echo "Important environment variables:"
echo "---------------------------------"

VARS=(USER HOME SHELL LANG PWD PATH HOSTNAME TERM EDITOR LOGNAME)

for VAR in "${VARS[@]}"; do
    if [[ -n "${!VAR:-}" ]]; then
        echo "$VAR = ${!VAR}"
    else
        echo "$VAR = (not set)"
    fi
done
