#!/bin/bash

# set -eu
# set -o pipefail


_SOURCE_FILE=${BASH_SOURCE[0]};
_SOURCE_FILE_BASENAME=`basename $_SOURCE_FILE`
_MODULE_HASH_KEY="`sed -r 's/\./_/g' <<< "$_SOURCE_FILE_BASENAME"`_`cat "$_SOURCE_FILE" | sha1sum | awk '{print $1}'`";
_FINAL_SOURCE_FILE="$_BASH_UTILS_TMP_DIR/$_MODULE_HASH_KEY"
[[ -f $_FINAL_SOURCE_FILE ]] && return || touch $_FINAL_SOURCE_FILE

echo "load module: $_SCRIPT_ABS_DIR/$_SOURCE_FILE_BASENAME"

strlen() {
  if [[ $# -eq 0 ]]; then
    echo 0;
    return 0;
  fi
  local s="$1";
  echo -n "${#s}";
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
    echo -n "$s";
    return;
  fi

  if [[ $# -ge 3 ]]; then
    length="$3"
  else # substr arg1 arg2
    echo -n "${s:$startIndex}";
    return;
  fi
  echo -n "${s:$startIndex:$length}";
}

ltrim() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi

	local s="$(echo $1 | sed -r 's/^\s*//g')"
	echo -n "$s"
}

rtrim() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi

	local s="$(echo $1 | sed -r 's/\s*$//g')"
	echo -n "$s"
}

trim() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi

	local s="$(echo $1 | sed -r 's/^\s*|\s*$//g')"
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
	echo -n "$ret";
}

strtolower() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi
	local s=$(echo "$1" | tr 'a-z' 'A-Z')
	echo -n "$s"
}

strtoupper() {
	if [[ $# -lt 1 ]]; then
		echo -n "";
		return;
	fi
	local s=$(echo "$1" | tr 'A-Z' 'a-z')
	echo -n "$s"
}
