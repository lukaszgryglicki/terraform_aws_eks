# Run the example on AWS EKS

- `./build.sh your_docker_username`.
- `./deploy.sh your_docker_username`.
- You will see (after some time) `EXTERNAL-IP` for `aws-eks-hello` service (from `kubectl get svc`).
- Open `EXTERNAL-IP:8080` for example: `http://00000000000000000000000000000000-111111111.us-west-2.elb.amazonaws.com:8080`.
- You will see `Hello World!`.
- `./destroy.sh`.
