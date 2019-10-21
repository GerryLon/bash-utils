#!/bin/bash

# set -eu
# set -o pipefail

_SOURCE_FILE="${BASH_SOURCE[0]}";
_SOURCE_FILE_BASENAME=`basename $_SOURCE_FILE`
_SCRIPT_ABS_DIR=$(cd `dirname $_SOURCE_FILE`; pwd)
_MODULE_HASH_KEY="`sed -r 's/\./_/g' <<< "$_SOURCE_FILE_BASENAME"`_`cat "$_SOURCE_FILE" | sha1sum | awk '{print $1}'`";
_BASH_UTILS_TMP_DIR="$_SCRIPT_ABS_DIR/tmp"
_FINAL_SOURCE_FILE="$_BASH_UTILS_TMP_DIR/$_MODULE_HASH_KEY"
[[ ! -d "$_BASH_UTILS_TMP_DIR" ]] && mkdir -p "$_BASH_UTILS_TMP_DIR"
[[ -f $_FINAL_SOURCE_FILE ]] && return || touch $_FINAL_SOURCE_FILE

echo "load module: $_SCRIPT_ABS_DIR/$_SOURCE_FILE_BASENAME"

# scriptDir=$(cd `dirname $0`; pwd);
MODULE_DIR="$(cd `dirname $_SOURCE_FILE`; pwd)/modules"

. "$MODULE_DIR/str.sh"
