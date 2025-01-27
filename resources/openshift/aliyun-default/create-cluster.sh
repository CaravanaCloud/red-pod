
exit 42;



commented() {


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
