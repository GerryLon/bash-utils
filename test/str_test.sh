#!/bin/bash

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
