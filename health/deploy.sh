#!/bin/bash
if [ -z "${AWS_PROFILE}" ]
then
  echo "usage: AWS_PROFILE=... ${0}"
  exit 1
fi
kubectl apply -f health_deployment.yaml
kubectl get deployments
kubectl expose deployment ekshealthtest --type=LoadBalancer --port=8888
kubectl get po
kubectl get svc
echo "Repeat 'kubectl get svc' until EXTERNAL-IP is available"
