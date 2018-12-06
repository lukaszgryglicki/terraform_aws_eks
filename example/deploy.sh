#!/bin/bash
if ( [ -z "${1}" ] || [ -z "${AWS_PROFILE}" ] )
then
  echo "usage: AWS_PROFILE=... ${0} docker_username"
  exit 1
fi
kubectl create deployment aws-eks-hello --image="docker.io/${1}/aws-eks-hello"
kubectl get deployments
kubectl expose deployment aws-eks-hello --type=LoadBalancer --port=8080
kubectl get po
kubectl get svc
echo "Repeat 'kubectl get svc' until EXTERNAL-IP is available"
