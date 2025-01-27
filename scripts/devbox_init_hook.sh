#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_DIR="$(dirname $DIR)"

source $DIR/install-clients.sh
export DEVBOX_INIT_HOOK="success"
echo "Devbox init hook successful"
