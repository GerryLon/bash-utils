#!/bin/bash

scriptDir=$(cd `dirname $0`; pwd)

. $scriptDir/index.sh
. $scriptDir/assert.sh

test_strlen() {
    local s="hello world";
    assert $(strlen "${s}") 11;
}

for i in test_strlen; do
    $i;
done
