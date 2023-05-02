#!/usr/bin/env bash

CLUSTER_NAME=dashboard

if eksctl utils describe-stacks --region=us-east-1 --cluster=${CLUSTER_NAME} | grep -q ${CLUSTER_NAME}; then
    echo "Cluster already exists!"
else
    echo "Creating..."
    eksctl create cluster -f manifests/cluster.yml
fi