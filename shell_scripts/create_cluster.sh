#!/usr/bin/env bash


if kubectl config get-clusters | grep -q dashboard; then
    echo "Cluster already exists!"
else
    echo "Creating..."
    eksctl create cluster -f manifests/cluster.yml
fi