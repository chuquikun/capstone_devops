#!/usr/bin/env bash

CLUSTER_NAME="dashboard"
REGION="us-east-1"
CLUSTER_FULL_NAME="${CLUSTER_NAME}.${REGION}.eksctl.io"

if kubectl config get-clusters | grep -q $CLUSTER_NAME; then
    eksctl delete cluster --region=us-east-1 --name=$CLUSTER_NAME &&
    echo "Cluster deleted on eks!"
    kubectl config delete-cluster $CLUSTER_FULL_NAME &&
    echo "Cluster deleted from kube-config!"
else
    echo "There is no such cluster to be deleted."
fi

