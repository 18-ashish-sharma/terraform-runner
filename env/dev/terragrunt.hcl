locals {
  cluster_full_name = "ksmart-platform-dev-us-east-1.k8s.local"
  kube_config_path  = pathexpand("./${local.cluster_full_name}.config")
  aws_region        = "us-east-1"
  bucket            = "ksmrat-platform-tfstate-dev"
  cluster_name      = "ksmart-platform-cluster-dev"
  cluster_version   = "1.24"
  account_id        = "344552514311"
  profile           = "ksmart-dev"
  namespaces        = ["workshop"]
  cidr              = "10.106.0.0/16"
  azs               = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets   = ["10.106.1.0/24", "10.106.2.0/24", "10.106.3.0/24"]
  public_subnets    = ["10.106.101.0/24", "10.106.102.0/24", "10.106.103.0/24"]
}

inputs = {
  cluster_name = local.cluster_name
  account_id   = local.account_id
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
provider "kubernetes" {
  config_path = "${local.kube_config_path}"
}
provider "helm" {
  kubernetes {
    config_path = "${local.kube_config_path}"
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket = "${local.bucket}"
    key    = "${local.cluster_full_name}/${basename(get_repo_root())}/terraform.tfstate"
    region = "${local.aws_region}"
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "~> 1.2.6"
  backend "s3" {
    bucket         = "${local.bucket}"
    key            = "${local.cluster_full_name}/${basename(get_repo_root())}/terraform.tfstate"
    region         = "${local.aws_region}"
  }
}
EOF
}
