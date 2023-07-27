#!/bin/bash
set -ex

# https://javiermugueta.blog/2021/05/31/useful-oci-cli-recipes-part-one/

# oci session authenticate
OCI_PROFILE="oci-redpod"
OCI_XARGS="--config-file $HOME/.oci/config --profile $OCI_PROFILE --auth security_token"

oci iam region list $OCI_XARGS && echo "OCI CLI is working" 

# OCI_REGION=$(oci iam region-subscription list $OCI_XARGS | jq -r '.data[0]."region-name"')
OCI_REGION="us-sanjose-1"
OCI_COMPARTMENT_NAME="ocp-oci-bm"
OCI_COMPARTMENT_ID="ocid1.compartment.oc1..aaaaaaaaw5ufp35mxetgga6v6ql4e23qdvh7xhsqkk2vs3khtz56jwxyuksq"
OCI_ZONE="splat-oci.devcluster.openshift.com"
OCI_ZONE_ID="ocid1.dns-zone.oc1..aaaaaaaawi6vsvnclcgdnlsb3hriyi5qd3pm4sit4k2csszltqk6jh6nbpfa"





echo "Using region $OCI_REGION"
