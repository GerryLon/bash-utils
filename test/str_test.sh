#!/bin/bash

_SOURCE_FILE=${BASH_SOURCE[0]};
_SOURCE_FILE_BASENAME=`basename $_SOURCE_FILE`
_MODULE_HASH_KEY="`sed -r 's/\./_/g' <<< "$_SOURCE_FILE_BASENAME"`_`cat "$_SOURCE_FILE" | sha1sum | awk '{print $1}'`";
_FINAL_SOURCE_FILE="$_BASH_UTILS_TMP_DIR/$_MODULE_HASH_KEY"
[[ -f $_FINAL_SOURCE_FILE ]] && return || touch $_FINAL_SOURCE_FILE

echo "load module: $_SCRIPT_ABS_DIR/$_SOURCE_FILE_BASENAME"

MODULE_DIR="$(cd `dirname $0`; pwd)/../modules"

. "$MODULE_DIR/str.sh"
. "$MODULE_DIR/assert.sh"

test_strlen() {
    local s="hello world";
    assert $(strlen "${s}") 11;
}

for i in test_strlen; do
    $i;
done
