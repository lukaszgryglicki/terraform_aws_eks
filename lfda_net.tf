module "base_vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "dev-analytics-${var.ENV}"
  cidr = "${var.vpc_cidr}"

  azs             = ["${var.vpc_azs}"]
  private_subnets = ["${var.vpc_cidr_private}"]
  public_subnets  = ["${var.vpc_cidr_public}"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "${var.tag_env}"
    Project = "${var.project}"
  }
}
