#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest"

mkdir -p "${DIR}/../bin"

fetch(){
    echo "Fetching ${1}"
    fname=$1
    wget "${BASE_URL}/${fname}"
    tar zxvf "${fname}" -C "${DIR}/../bin"
    rm -f "${fname}"
    echo "Fetch complete for ${1}"
}

fetch "openshift-client-linux.tar.gz"
fetch "ccoctl-linux.tar.gz"
fetch "openshift-install-linux.tar.gz"

echo "try: "
eho "export PATH=\$PATH:/workspace/red-pod/bin"
echo "Clients installed"
