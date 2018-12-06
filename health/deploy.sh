#!/bin/bash
if [ -z "${AWS_PROFILE}" ]
then
  echo "usage: AWS_PROFILE=... ${0}"
  exit 1
fi
if [ -z "${EKS_HEALTH_PORT}" ]
then
  EKS_HEALTH_PORT=8888
fi
#kubectl apply -f health_deployment.yaml
cat health_deployment.yaml | envsubst | kubectl apply -f -
kubectl get deployments
kubectl expose deployment ekshealthtest --type=LoadBalancer --port="${EKS_HEALTH_PORT}"
kubectl get po
kubectl get svc
kubectl set env pods --all --list
echo "Repeat 'kubectl get svc' until EXTERNAL-IP:${EKS_HEALTH_PORT} is available"
