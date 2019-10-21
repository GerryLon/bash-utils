#!/bin/bash

_SOURCE_FILE=${BASH_SOURCE[0]};
_SOURCE_FILE_BASENAME=`basename $_SOURCE_FILE`
_MODULE_HASH_KEY="`sed -r 's/\./_/g' <<< "$_SOURCE_FILE_BASENAME"`_`cat "$_SOURCE_FILE" | sha1sum | awk '{print $1}'`";
_FINAL_SOURCE_FILE="$_BASH_UTILS_TMP_DIR/$_MODULE_HASH_KEY"
[[ -f $_FINAL_SOURCE_FILE ]] && return || touch $_FINAL_SOURCE_FILE

echo "load module: $_SCRIPT_ABS_DIR/$_SOURCE_FILE_BASENAME"

# assertExitCode(returnValue, msg)
# 一般用法: command; assert $?
assertExitCode() {
    if [[ $# -lt 1 ]]; then
        echo "assert params invalid";
        exit 1;
    fi

    if [[ $# -ge 1 ]]; then
        local msg="Assert Error!"
        if [[ $# -ge 2 ]]; then
            msg="$2"
        fi

        if [[ $1 -ne 0 ]]; then # 判断是不是0, 不是就报错
            echo $msg
            exit 2
        fi
    fi
}

assertStrEqual() {
    if [[ $# -ne 2 ]]; then
        echo "usage: assertStrEqual str1 str2";
        exit 1;
    fi
    [[ "$1" == "$2" ]] || { echo "[assertStrEqual]: $1 and $2 are not equal"; exit 1; }
}

# assert为assertStrEqual的别名
assert() {
    assertStrEqual $@
}
