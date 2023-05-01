#!/usr/bin/env bash

DEPLOYMENT_NAME="server"
LOADBALANCER_NAME="loadbalancer-service"

# Remove deployment
echo "Deleting deployment ${DEPLOYMENT_NAME}"
echo "..."
kubectl delete deployments ${DEPLOYMENT_NAME}


# Remove 
echo "Deleting service: ${LOADBALANCER_NAME}"
kubectl delete services ${LOADBALANCER_NAME}


# Show cluster's resources
echo
echo "Listing services"
kubectl get services
echo
echo "Listing deployments"
kubectl get deployments
echo
echo "Listting pods"
kubectl get pods