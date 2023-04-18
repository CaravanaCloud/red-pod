base_url="https://mirror.openshift.com/ub/openshift-v4/x86_64/clients/ocp/4.12.7"
fetch(){
    fname=$1
    if [ ! -f "${fname}" ]; then
        wget "${base_url}/${fname}"
    fi    
    tar zxvf "${fname}"    
}

# fetch "openshift-client-linux.tar.gz"
# fetch "ccoctl-linux.tar.gz"
# fetch "openshift-install-linux.tar.gz"