# can be used for more env variables

locals {
  environment = "development"
  capacity_type = "SPOT"
  instance_types = ["t3a.xlarge"]
  github_repo    = "edstem-tech-infra-ikm"
  github_organization = "edstem-tech"
  efs_policy_name = "AmazonEKS_EFS_CSI_Driver_Policy"
  alb_policy_name = "AWSLoadBalancerControllerIAMPolicy"
  efs_name        = "aws-efs-csi-driver-storage"
}
