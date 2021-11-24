#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# in my case the dockerpath is not used in this script but in the pod specification yaml instead
dockerpath=1802/udacity_project4:flaskapp
# Step 2
# Run the Docker Hub container with kubernetes
kubectl apply -f pod-spec.yaml 


# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward flaskapp 8000:80

