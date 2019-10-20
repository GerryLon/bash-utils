#!/bin/bash

MODULE_DIR="$(cd `dirname ${BASH_SOURCE[0]}`; pwd)/../modules"

. "$MODULE_DIR/is.sh"
. "$MODULE_DIR/assert.sh"

test_is_ipv4() {
	is_ipv4 "192.168.33.22";
	assertExitCode $?;

	is_ipv4 "0.0.0.0";
	assertExitCode $?;

	is_ipv4 "255.255.255.255";
	assertExitCode $?;

	is_ipv4 "192.168.255.256"
	assertOnlyShowMsg $? 0
}

for i in test_is_ipv4; do
    $i;
done
