#!/usr/bin/env bash

set -e
set -u
set -o pipefail
umask 077

workspace="${HOME}/hexagon/00_operator_advanced"
temporary=''

cleanup()
{
    if [[ -n "$temporary" &&
    "$temporary" == "$workspace"/99_scratch/.scratch.* &&
    -d "$temporary" ]]
    
    then
        rm -rf -- "$temporary"
    fi
}

trap cleanup EXIT

mkdir -p -- "$workspace/99_scratch"

chmod 700 -- \
"$workspace" \
"$workspace/99_scratch"

temporary="$(
    mktemp -d \
    --tmpdir="$workspace/99_scratch" \
    '.scratch.XXXXXX'
)"

printf '%s\n' 'SCRATCH DATA' \
   > "$temporary/data.txt"

cat "$temporary/data.txt"