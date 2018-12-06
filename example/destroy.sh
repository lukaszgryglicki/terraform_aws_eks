#!/bin/bash
if [ -z "${AWS_PROFILE}" ]
then
  echo "usage: AWS_PROFILE=... ${0}"
  exit 1
fi
kubectl delete service aws-eks-hello
kubectl delete deployment aws-eks-hello
