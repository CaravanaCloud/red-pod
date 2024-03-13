#!/bin/bash
set -x

# generate configuration from template
export CLUSTER_NAME=${CLUSTER_NAME:-"$USER$(date +%m%d%H%M)"}
export CLUSTER_DIR=".$CLUSTER_NAME"
export SSH_KEY=$(cat $HOME/.ssh/id_rsa.pub)

mkdir -p $CLUSTER_DIR
envsubst < install-config.env.yaml > $CLUSTER_DIR/install-config.yaml
cp $CLUSTER_DIR/install-config.yaml $CLUSTER_DIR/install-config.bak.yaml

aws sts get-caller-identity
sleep 30

openshift-install create cluster --dir=$CLUSTER_DIR
echo done

