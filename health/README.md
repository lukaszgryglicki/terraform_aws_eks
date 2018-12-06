# Run the health test on AWS EKS

- `./pull.sh`.
- `EKS_HEALTH_PORT=8008 PG_SSL=disable PG_HOST="aurora_db_url" PG_PORT=aurora_port PG_USER=sa PG_DB=postgres PG_PASS="aurora_db_pass" ES_HOST="es_host" ES_PORT=es_port ES_PROTO="https" ./deploy.sh`.
- You will see (after some time) `EXTERNAL-IP` for `ekshealthtest` service (from `kubectl get svc`).
- Open `EXTERNAL-IP:8008` for example: `http://00000000000000000000000000000000-111111111.us-west-2.elb.amazonaws.com:8008`.
- You will see health status.
- `./destroy.sh`.
