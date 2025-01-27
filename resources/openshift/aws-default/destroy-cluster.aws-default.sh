#!/bin/bash
set -x

export CLUSTER_DIR=".$CLUSTER_NAME"
openshift-install destroy cluster --dir=$CLUSTER_DIR
