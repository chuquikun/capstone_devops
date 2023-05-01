#!/usr/bin/env bash

tag="${1:-blue}"

echo $tag

# Retrieve an authentication token and authenticate your Docker client to your registry.
aws ecr get-login-password --region us-east-1 | \
    docker login --username AWS --password-stdin 530835307231.dkr.ecr.us-east-1.amazonaws.com

# Tag your image so you can push the image to this repository
docker tag capstone:$tag 530835307231.dkr.ecr.us-east-1.amazonaws.com/capstone:$tag

# Push this image AWS-ECR repository
docker push 530835307231.dkr.ecr.us-east-1.amazonaws.com/capstone:$tag