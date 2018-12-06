#!/bin/bash
if [ -z "${1}" ]
then
  echo "usage: ${0} docker_username"
  exit 1
fi
docker login || exit 2
docker build -t aws-eks-hello . || exit 3
docker tag aws-eks-hello "${1}/aws-eks-hello" || exit 4
docker push "${1}/aws-eks-hello" || exit 5
