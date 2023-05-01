#!/usr/bin/env bash

# kubernetes cluster is needed
kubectl get nodes
# deploy app to the to kubernetes cluster
kubectl apply -f manifests/deployment_manifest.yml
# use a load balancer service to access externally the application
kubectl create -f manifests/lb_manifest.yml
# the external-ip for the service can be retrieved from this output
kubectl get service/loadbalancer-service |  awk {'print $1" " $2 " " $4 " " $5'} | column -t
# See the status
kubectl get deploy,rs,svc,pods

