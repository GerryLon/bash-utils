#!/bin/bash

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
