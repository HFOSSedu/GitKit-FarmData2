#!/usr/bin/env bash

## Called by KitClient to install features.
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

set -e

## Move to the root of the project.
cd "$SCRIPT_DIR"
while [[ ! -d .git ]] ; do
    cd ..
done

## Install features into the client.
for feature in ./.kit/features/* ; do
    script="$feature"/install-into-client.sh
    if [[ -e "$script" ]] ; then
        "$script"
    fi
done

## Run post installs.
for feature in ./.kit/features/* ; do
    script="$feature"/post-install-into-client.sh
    if [[ -e "$script" ]] ; then
        "$script"
    fi
done
