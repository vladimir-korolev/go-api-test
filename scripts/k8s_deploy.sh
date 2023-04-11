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
# Deploy k8s manifest
sed "s/__IMAGE_TAG__/0.0.3/g" k8s/k8smanifest.yaml | kubectl apply -f -
kubectl -n myns scale deploy/go-api --replicas=3