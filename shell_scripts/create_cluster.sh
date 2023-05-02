#!/usr/bin/env bash


if /bin/kubectl config get-clusters | grep -q dashboard; then
    echo "Cluster already exists!"
else
    echo "Creating..."
    /bin/eksctl create cluster -f manifests/cluster.yml
fi