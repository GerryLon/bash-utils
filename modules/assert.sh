#!/bin/bash

set -eE -o functrace

_traceFailure() {
    local func="$1"
    local lineno="$2"
    local msg="$3"
    echo "Failed at func:$func, linenum:$lineno: msg: $msg"
}
trap '_traceFailure ${FUNCNAME} ${LINENO} "$BASH_COMMAND"' ERR

# usage: command; assert $? expectedExitCode
assertExitCode() {
    if [[ $# -lt 1 ]]; then
        echo "assert params invalid";
        return 1;
    fi

    local expectedExitCode=0;
    if [[ $# -ge 2 ]]; then
        expectedExitCode=$2;
    fi

    if [[ $1 -ne $expectedExitCode ]]; then
        echo "[assertExitCode]: expected: $expectedExitCode, got: $1";
        return 2;
    fi
}

assertStrEqual() {
    if [[ $# -ne 2 ]]; then
        echo "usage: assertStrEqual str1 str2";
        return 1;
    fi
    if [[ "$1" != "$2" ]]; then
        echo "[assertStrEqual]: $1 and $2 are not equal";
        return 2;
    fi
}

assertStrNotEqual() {
    if [[ $# -ne 2 ]]; then
        echo "usage: assertStrNotEqual str1 str2";
        return 1;
    fi
    if [[ "$1" == "$2" ]]; then
        echo "[assertStrNotEqual]: $1 and $2 are equal";
        return 2;
    fi
}

# assert is an alias of assertStrEqual
# when assert fails, exit directly
assert() {
    assertStrEqual $@;
    local ret=$?;
    [[ $ret -ne 0 ]] && exit $ret;
}

assertNot() {
    assertStrEqual $@;
    local ret=$?;
    [[ $ret -eq 0 ]] && exit $ret;
}

assertOnlyShowMsg() {
    assertStrEqual $@;
}

assertNotOnlyShowMsg() {
    assertStrNotEqual $@;
}
