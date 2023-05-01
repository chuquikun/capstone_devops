#!/usr/bin/env bash

tag="${1:-blue}"

# build docker image
docker build -t capstone:$tag .