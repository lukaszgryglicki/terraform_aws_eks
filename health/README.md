# Run the health test on AWS EKS

- `./pull.sh`.
- `./deploy.sh`.
- You will see (after some time) `EXTERNAL-IP` for `ekshealthtest` service (from `kubectl get svc`).
- Open `EXTERNAL-IP:8080` for example: `http://00000000000000000000000000000000-111111111.us-west-2.elb.amazonaws.com:8080`.
- You will see `Hello World!`.
- `./destroy.sh`.
