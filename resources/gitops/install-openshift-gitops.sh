#!/bin/bash

oc create ns cert-manager-operator
oc apply -f openshift-gitops-sub.k8s.yaml
sleep 30
oc get pods -n openshift-operators
oc get pods -n openshift-gitops
sleep 10
GITOPS_SERVER=$(oc get route -n openshift-gitops -o json | jq '.items[] | select(.metadata.name | contains("openshift-gitops-server")).spec.host' -r)
echo GITOPS_SERVER=$GITOPS_SERVER
# oc get secret openshift-gitops-cluster  -n openshift-gitops -o jsonpath="{.data.admin\.password}" | base64 -d
# oc top pods   -n openshift-gitops