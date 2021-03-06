# AWS EKS Kubernetes cluster using Terraform

# Install terraform

- Have all you AWS credentials/config configured in `~/.aws/` - they will be used by this deployment.
- `wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip`.
- `unzip terraform_0.11.10_linux_amd64.zip`.
- `rm terraform_0.11.10_linux_amd64.zip`.
- `mv terraform /usr/bin/`.
- `AWS_PROFILE=lfda-tf terraform init`.
- `AWS_PROFILE=lfda-tf terraform plan`.
- `AWS_PROFILE=lfda-tf terraform apply`.`
- Put outputs config in the `cluster_setup_manifests`directory: `config_map.yml kube_config.yml`.
- `mkdir ~/.kube; cp cluster_setup_manifests/kube_config.yml ~/.kubec/config`.
- `AWS_PROFILE=lfda-tf kubectl cluster-info` -> `Kubernetes master is running at https://0000000000000000000000000000.sk1.us-west-2.eks.amazonaws.com`.
- `AWS_PROFILE=lfda-tf kubectl apply -f cluster_setup_manifests/config_map.yml` --> `configmap/aws-auth created`
- You can now do `export AWS_PROFILE=lfda-tf`, followed by `kubectl get nodes`. You should now get 2 nodes.
- To make an example Kubernetes application (very simple) follow `example/README.md`.
- Then install health check app `health/README.md`.
