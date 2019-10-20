#!/bin/bash

is_ipv4() {
	if [[ $# -lt 1 ]]; then
	return 1;
	fi
	local ip="$1";
	local arr=(${ip//\./ }); # split by "."

	# length should be 4
	if [[ ${#arr[@]} -ne 4 ]]; then
	return 2;
	fi

	for num in ${arr[@]}; do
		if [[ $num -lt 0 ]] || [[ $num -gt 255 ]]; then
		return 3;
		fi
	done

	return 0;
}
