# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  required_version = "~> 1.2.6"
  backend "s3" {
    bucket         = "ksmrat-platform-tfstate-dev"
    key            = "ksmart-platform-dev-us-east-1.k8s.local/infra-ikm/terraform.tfstate"
    region         = "us-east-1"
  }
}
