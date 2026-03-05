
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # eks cluster name and version
  cluster_name    = "${var.project}-${var.environment}"
  cluster_version = "1.33"
  bootstrap_self_managed_addons = true
  cluster_upgrade_policy = {
  support_type = "STANDARD"
   //support_type = "EXTENDED"
  }
  cluster_addons = {
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry!
  enable_cluster_creator_admin_permissions = true
#enable_irsa	Determines whether to create an OpenID Connect Provider for EKS to enable IRSA
enable_irsa = true

  # vpc id where the eks cluster security group needs to be created
  vpc_id                   =  data.aws_vpc.selected.id

 # subnets where the eks node groups needs to be created
  subnet_ids               = data.aws_subnets.private_subnets.ids

  # subnets where the eks cluster needs to be created
  control_plane_subnet_ids = data.aws_subnets.private_subnets.ids
}