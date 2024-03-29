#!/bin/bash
set -ex

check_variables() {
  for var in "$@"; do
    if [ -z "${!var}" ]; then
      echo "Error: Variable '$var' is not set or has zero length." >&2
      exit 1
    fi
  done
}

export AWS_REGION=${AWS_REGION:-"us-west-2"}
export CLUSTER_NAME=${CLUSTER_NAME:-"$(basename $GITPOD_REPO_ROOT)-$RANDOM"} 
export OCP_BASE_DOMAIN=${OCP_BASE_DOMAIN:-"devcluster.openshift.com"}
export SSH_KEY=$(cat $HOME/.ssh/id_rsa.pub)
check_variables "AWS_REGION" "OCP_BASE_DOMAIN" "PULL_SECRET" "SSH_KEY"

aws sts get-caller-identity
envsubst < "install-config.aws-singletiny.env.yaml" > "install-config.yaml"
cp "install-config.yaml" "install-config.bak.yaml"

echo "WARNING: This will run 1 x t3a.xlarge instances on your AWS account."
sleep 5

openshift-install create cluster
openshift-install wait-for install-complete

mkdir -p "$HOME/.kube"
ln -sf "${GITPOD_REPO_ROOT}/auth/kubeconfig" "$HOME/.kube/config"

oc cluster-info
# oc get route -n openshift-gitops -o json | jq '.items '

# some things to try
# kubectl get nodes
# kubectl get deployments --all-namespaces
# kubectl run -it --rm --restart=Never --image=busybox:1.33.1 testpod -- /bin/sh


echo "cluster created."
