#!/usr/bin/env bash

## This script is called after the new instance has been created and
## initialiazed. It runs in the local clone of the instance.

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
cd "$SCRIPT_DIR"

set -e

i=0
o="$(yq ".[${i}]" < issues.json)"

while [[ "$o" != "null" ]] ; do
    title="$(echo "$o" | yq '.title')"
    body="$(echo "$o" | yq '.body')"
    labels="$(echo "$o" | yq '.labels[]' | sed ':a;N;$!ba;s/\n/,/g')"
    echo "Creating issue: $title"
    gh issue create --title "$title" --body "$body" --label "$labels"
    sleep 3
    ((++i))
    o="$(yq ".[${i}]" < issues.json)"
done
