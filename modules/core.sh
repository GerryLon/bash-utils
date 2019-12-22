#!/bin/bash

# set -eu
# set -o pipefail

# rand: generate random from $1 to $2(both included, [$1, $2])
# $1: default is 1
# $2: default is 10
rand() {
    local min="${1:-1}"
    local max="${2:-10}"
    local result=$((RANDOM%(max-min+1))) # [0, max-min+1)
    result=$((result+min)) # [min, max+1) => [min, max]
    echo ${result}
}
