#!/bin/bash 

oc apply -f openshift-certmanager-sub.k8s.yaml
sleep 30
oc get pods -n openshift-operators

