expect_vars() {
  for var in "$@"; do
    if [[ -z "${!var}" ]]; then
      echo "Error: ${var} is not set or is empty." >&2
      exit 1
    fi
  done
}

gen_cluster_name() {
  local prefix="redpod"
  local separator="--"
  local timestamp
  timestamp="$(date +"%m%d%H%M")"
  echo "${prefix}${separator}${timestamp}"
}

log() {
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  message="$*"
  echo "${timestamp} ${region} ${message}"  | tee -a "${0}.log.txt"
}
