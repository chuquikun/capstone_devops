#!/usr/bin/env bash
KUBECTL=kubectl
LOAD_BALANCER=loadbalancer-service
# kubernetes cluster is needed
#${KUBECTL} get nodes
# deploy app to the to kubernetes cluster
${KUBECTL} apply -f manifests/deployment_manifest.yml
# use a load balancer service to access externally the application

#if ${KUBECTL} get service  | grep -q ${LOAD_BALANCER}; then
#    echo "Load balancer exists!"
#else
#    echo "Creating  load balancer service..."
#    ${KUBECTL} create -f manifests/lb_manifest.yml
#fi

# the external-ip for the service can be retrieved from this output
${KUBECTL} get service/loadbalancer-service
# See the status
${KUBECTL} get deploy,rs,svc,pods

