#!/usr/bin/env bash

DEPLOYMENT_NAME=server
CONTAINER_NAME=back-end
UPDATED_IMAGE=530835307231.dkr.ecr.us-east-1.amazonaws.com/capstone:green

#  The set image command will overwrite the existing deployment and update it with the UPDATE_IMAGE
kubectl set image deployments/${DEPLOYMENT_NAME} \
		${CONTAINER_NAME}=${UPDATED_IMAGE}

echo
# the external-ip for the service can be retrieved from this output
kubectl get service/loadbalancer-service
echo
# In order to see the rollout status
kubectl get rs -o wide
echo 
kubectl get deployments -o wide
kubectl describe pods | grep -i image


