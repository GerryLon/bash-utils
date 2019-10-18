#!/bin/bash

# set -eu
# set -o pipefail

strlen() {
  if [[ $# -eq 0 ]]; then
    echo 0;
    return 0;
  fi
  local s="$1";
  echo -n ${#s};
}

# substr(str, startIndex, [length])
substr() {
  if [[ $# -eq 0 ]]; then
    echo -n "";
    return;
  fi

  local s='' startIndex=0 length=0

  if [[ $# -ge 1 ]]; then
    s="$1";
  else # substr
    echo -n "";
    return;
  fi

  if [[ $# -ge 2 ]]; then
    startIndex="$2";
  else # substr arg1
    echo -n $s;
    return;
  fi

  if [[ $# -ge 3 ]]; then
    length="$3"
  else # substr arg1 arg2
    echo -n ${s:$startIndex}
    return;
  fi
  echo -n ${s:$startIndex:$length}
}

trim() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi

	local s=$(echo $1 | sed -r 's/^\s*|\s*$//g')
	echo -n "$s"
}

# str_repeat(str, num)
str_repeat() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi
	local s="$1" n=${2:-1}
	local i
	local ret=''
	for ((i=0; i<$n; i++)); do
		ret="$ret$s";
	done
	echo -n $ret;
}
