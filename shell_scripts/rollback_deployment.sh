#!/usr/bin/env bash

DEPLOYMENT_NAME=server

# rollback to the previous version in case we need to go back to earlier deployment   
kubectl rollout undo deployment ${DEPLOYMENT_NAME} 

echo
# the external-ip for the service can be retrieved from this output
kubectl get service/loadbalancer-service |  awk {'print $1" " $2 " " $4 " " $5'} | column -t
echo
# In order to see the rollout status
kubectl get rs -o wide
echo 
kubectl get deployments -o wide
echo
kubectl get pods 