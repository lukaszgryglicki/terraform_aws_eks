#!/bin/bash
kubectl exec -it `kubectl get po | awk '/ekshealthtest/ {print $1}'` -- /bin/bash
