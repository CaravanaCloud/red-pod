#!/bin/bash
# set -x 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_DIR="$(dirname $DIR)"

export TARGET_DIR="$REPO_DIR/.local/bin"
mkdir -p "$TARGET_DIR"

# OpenShift Installer
if ! command -v openshift-install &> /dev/null; then
    echo "Downloading OpenShift Installer..."
    mkdir -p "/tmp/openshift-installer"
    wget -q  -O "/tmp/openshift-installer/openshift-install-linux.tar.gz" "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-install-linux.tar.gz"
    tar zxvf "/tmp/openshift-installer/openshift-install-linux.tar.gz" -C "/tmp/openshift-installer"
    mv  "/tmp/openshift-installer/openshift-install" "$TARGET_DIR"
    rm "/tmp/openshift-installer/openshift-install-linux.tar.gz"
    echo "OpenShift Installer downloaded and moved to $TARGET_DIR"
fi
    
# Credentials Operator CLI
if ! command -v ccoctl &> /dev/null; then
    echo "Downloading Credentials Operator CLI..."
    mkdir -p "/tmp/ccoctl"
    wget -q  -O "/tmp/ccoctl/ccoctl-linux.tar.gz" "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/ccoctl-linux.tar.gz"
    tar zxvf "/tmp/ccoctl/ccoctl-linux.tar.gz" -C "/tmp/ccoctl"
    mv "/tmp/ccoctl/ccoctl" "$TARGET_DIR"
    rm "/tmp/ccoctl/ccoctl-linux.tar.gz"
    echo "Credentials Operator CLI downloaded and moved to $TARGET_DIR"
fi

# OpenShift CLI
if ! command -v oc &> /dev/null; then
    echo "Downloading OpenShift CLI..."
    mkdir -p "/tmp/oc"
    wget -q  -O "/tmp/oc/openshift-client-linux.tar.gz" "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz"
    tar zxvf "/tmp/oc/openshift-client-linux.tar.gz" -C "/tmp/oc"
    mv "/tmp/oc/oc" "$TARGET_DIR"
    rm "/tmp/oc/openshift-client-linux.tar.gz"
    echo "OpenShift CLI downloaded and moved to $TARGET_DIR"
fi