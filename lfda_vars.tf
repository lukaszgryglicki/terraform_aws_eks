variable "project" {
  default = "dev-analytics"
}

variable "tag_env" {
  default = "dev"
}

variable "ENV" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.200.0.0/16"
}

variable "vpc_azs" {
  type = "list"
  default = ["us-west-2a", "us-west-2b"]
}

variable "vpc_cidr_public" {
  type = "list"
  default = ["10.200.101.0/24", "10.200.102.0/24"]
}

variable "vpc_cidr_private" {
  type = "list"
  default = ["10.200.1.0/24", "10.200.2.0/24"]
}
