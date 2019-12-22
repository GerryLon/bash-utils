#!/bin/bash

is_ipv4() {
	[[ $# -eq 0 ]] && return 1;
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

is_command() {
	[[ $# -eq 0 ]] && return 1;
	command -v "$1" >/dev/null 2>&1;
	return $?;
}

is_file() {
	[[ $# -eq 0 ]] && return 1;
	test -f $1;
	return $?;
}

is_dir() {
	[[ $# -eq 0 ]] && return 1;
	test -d $1;
	return $?;
}

is_exist() {
	[[ $# -eq 0 ]] && return 1;
	test -e $1;
	return $?;
}
