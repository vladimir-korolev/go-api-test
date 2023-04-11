#!/bin/sh
if [ $# -eq 0 ]
  then
    echo "Please use format:  helm_deploy.sh <VERSION>"
    exit 1
fi
app_ver=$1    # set docker image tag
# start minikube
minikube start
# Build docker image
docker build -t test-api:${app_ver} --build-arg GO_VERSION=1.20 .
# Load image to minikube in case of WSL
minikube image load test-api:${app_ver}
# For helm I'd recommend to create a namespace before running helm, not inside of helm chart.
# In this case we would run namespaced helm list/update/delete
kubectl create namespace myns
# Deploy helm chart
helm -n myns upgrade --install api ./charts/api --set image.tag=${app_ver},replicaCount=3
# We can use values.yaml instead of --set