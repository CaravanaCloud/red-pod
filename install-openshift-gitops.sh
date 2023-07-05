#!/bin/bash

oc apply -f openshift-gitops-sub.k8s.yaml
sleep 15
oc get pods -n openshift-operators
oc get pods -n openshift-gitops
sleep 5
GITOPS_SERVER=$(oc get route -n openshift-gitops -o json | jq '.items[] | select(.metadata.name | contains("openshift-gitops-server")).spec.host' -r)
echo GITOPS_SERVER=$GITOPS_SERVER
# oc get secret openshift-gitops-cluster  -n openshift-gitops -o jsonpath="{.data.admin\.password}" | base64 -d
