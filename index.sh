#!/bin/bash

# set -eu
# set -o pipefail

# scriptDir=$(cd `dirname $0`; pwd);
MODULE_DIR="$(cd `dirname $0`; pwd)/modules"

. "$MODULE_DIR/str.sh"
. "$MODULE_DIR/assert.sh"
