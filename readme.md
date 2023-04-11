# Description
## General
This is a simple golang "Hello World" microservice with k8s configuration and helm manifest.
In this project there are two implemented options to deploy the application to kubernetes - with helm chart and plain kubernetes manifest 
Common model of the project:
- Dockerfile is in root directory
- k8s manifests are in k8s directory
- helm charts are in charts directory
- build scripts are in scripts directory 

## Dockerfile
It was used multistaging build of the dockerfile. It will be good to have cached "builder" layer
In this dockerfile we can change version of golang during docker build

## k8s manifest
It's a plain k8s manifest. We should substitute image tag in order to simplify build script
Default count of replicas is 1 in order to demonstrate scale command. But we can set necessary number of replicas in the manifest

## helm charts
This helm chart was created from "helm create". There are some extra unused manifests which he can delete.
We can update helm values via --set parameters or a new values.yaml file

## build scripsts
There are provided some scripts:
- script to deploy the application via helm
- script to deploy the application via plain k8s manifest
- script to test these deployments