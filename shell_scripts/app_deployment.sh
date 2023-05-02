#!/usr/bin/env bash
LOAD_BALANCER=loadbalancer-service

# kubernetes cluster is needed
/bin/kubectl get nodes
# deploy app to the to kubernetes cluster
/bin/kubectl apply -f manifests/deployment_manifest.yml
# use a load balancer service to access externally the application

if /bin/kubectl get service  | grep -q ${LOAD_BALANCER}; then
    echo "Load balancer exists!"
else
    echo "Creating  load balancer service..."
    /bin/kubectl create -f manifests/lb_manifest.yml
fi

# the external-ip for the service can be retrieved from this output
/bin/kubectl get service/loadbalancer-service |  awk {'print $1" " $2 " " $4 " " $5'} | column -t
# See the status
/bin/kubectl get deploy,rs,svc,pods

