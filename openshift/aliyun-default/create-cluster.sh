#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source '../../utils.sh'

expect_vars "ALI_REGION" "ALI_BASEDOMAIN"

CLUSTER_NAME=$(gen_cluster_name)
CLUSTER_DIR="$DIR/$CLUSTER_NAME"
RELEASE_IMAGE=$(openshift-install version | awk '/release image/ {print $3}')

log "Creating cluster"
log "    name: ${CLUSTER_NAME}"
log "  region: ${ALI_REGION}"
log "     dir: ${CLUSTER_DIR}"
log " version: $(openshift-install version)"

mkdir -p "$CLUSTER_DIR"

envsubst < "./install-config.env.yaml" > "${CLUSTER_DIR}/install-config.yaml"
cp "${CLUSTER_DIR}/install-config.yaml" "${CLUSTER_DIR}/install-config.bak.yaml"
log "Generated install config"

exit 42;



commented() {



  manifests_dir="${dir}/manifests"
  log "Creating manifests at [$manifests_dir]"
  openshift-install create manifests --dir "${dir}"

  cred_reqs_dir="${dir}/cred_reqs"
  log "Extracting credential requests to [$cred_reqs_dir]"
  oc adm release extract \
    --credentials-requests \
    --cloud=alibabacloud \
    --to="${cred_reqs_dir}" \
    $RELEASE_IMAGE

  ccotl_out="${dir}/ccotl_out"
  log "Processing credentials requests to [$ccotl_out] "
  ccoctl alibabacloud create-ram-users \
    --name $CLUSTER_NAME \
    --region=$ALI_REGION \
    --credentials-requests-dir=${cred_reqs_dir} \
    --output-dir=${ccotl_out}

  log "Copy manifests"
  cp "${ccotl_out}/manifests"/*credentials.yaml "${manifests_dir}"

  log "Creating cluster"
  echo ./openshift-install create cluster --dir ${dir} --log-level=debug

  log "Set auth"
  echo export KUBECONFIG="${dir}/auth/kubeconfig"

  log "TODO: Collect logs"
  echo ./oc adm must-gather
  sleep 60

  log "Destroy cluster"
  echo ./openshift-install destroy cluster --dir ${dir} --log-level=debug

  log "Finished create cluster: ${region} at $(date)"
}


start_time=$(date +%s)
main
end_time=$(date +%s)
total_time=$((end_time - start_time))
total_time_minutes=$(log "scale=2; ${total_time}/60" | bc)
log "Total execution time: ${total_time_minutes} minutes"
