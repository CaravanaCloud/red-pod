#!/bin/bash
set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source '../../utils.sh'

expect_vars "ALI_REGION" "ALI_BASEDOMAIN"

CLUSTER_NAME=$(gen_cluster_name)
export CLUSTER_NAME

CLUSTER_DIR="$DIR/$CLUSTER_NAME"
RELEASE_IMAGE=$(openshift-install version | awk '/release image/ {print $3}')
MANIFESTS_DIR="${CLUSTER_DIR}/manifests"
CREDENTIAL_REQS_DIR="${CLUSTER_DIR}/cred_reqs"
CCOCTL_OUT="${CLUSTER_DIR}/ccotl_out"

log "Creating cluster"
log "        name: ${CLUSTER_NAME}"
log "      region: ${ALI_REGION}"
log "         dir: ${CLUSTER_DIR}"
log "     version: $(openshift-install version)"
log "   manifests: ${MANIFESTS_DIR}"
log " cred. reqs.: ${CREDENTIALS_REQ_DIR}"
log "  ccoctl out: ${CCOCTL_OUT}"

mkdir -p "$CLUSTER_DIR"

envsubst < "./install-config.env.yaml" > "${CLUSTER_DIR}/install-config.yaml"
cp "${CLUSTER_DIR}/install-config.yaml" "${CLUSTER_DIR}/install-config.bak.yaml"
log "Generated install config"


openshift-install create manifests --dir "${CLUSTER_DIR}"
log "Created manifests at [$MANIFESTS_DIR]"

oc adm release extract \
    --credentials-requests \
    --cloud=alibabacloud \
    --to="${CREDENTIAL_REQS_DIR}" \
    $RELEASE_IMAGE    
log "Extracted credential requests to [$CREDENTIAL_REQS_DIR]"


ccoctl alibabacloud create-ram-users \
    --name $CLUSTER_NAME \
    --region=$ALI_REGION \
    --credentials-requests-dir=${CREDENTIAL_REQS_DIR} \
    --output-dir=${CCOCTL_OUT}
log "Processed credentials requests to [$CCOCTL_OUT]"

cp "${CCOCTL_OUT}/manifests"/*credentials.yaml "${MANIFESTS_DIR}"
log "Copied manifests"

find $DIR
log "done."
