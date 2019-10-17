#!/bin/bash

set -eu
set -o pipefail

scriptDir=$(cd `dirname $0`; pwd)

strlen() {
  if [[ $# -eq 0 ]]; then
    echo 0;
    return 0;
  fi
  local s="$1";
  echo ${#s};
}

# substr(str, startIndex, [length])
substr() {
  if [[ $# -eq 0 ]]; then
    echo "";
    return;
  fi

  local s='' startIndex=0 length=0

  if [[ $# -ge 1 ]]; then
    s="$1";
  else # substr
    echo "";
    return;
  fi

  if [[ $# -ge 2 ]]; then
    startIndex="$2";
  else # substr arg1
    echo $s;
    return;
  fi

  if [[ $# -ge 3 ]]; then
    length="$3"
  else # substr arg1 arg2
    echo ${s:$startIndex}
    return;
  fi
  echo ${s:$startIndex:$length}
}
