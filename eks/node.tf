//removing the plugin atthe time of cluster ceration because it need node to be created first
resource "aws_eks_addon" "example" {
  depends_on = [ module.eks_managed_node_group ]
  cluster_name = module.eks.cluster_name
  addon_name   = "coredns"
}


# module "eks_managed_node_group" {
#   source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
#   cluster_service_cidr = module.eks.cluster_service_cidr
#   name            = "${var.project}-node"
#   cluster_name    = module.eks.cluster_name
#   cluster_version = "1.31"

#   subnet_ids = data.aws_subnets.private_subnets.ids
#   min_size     = 1
#   max_size     = 2
#   desired_size = 1

#   instance_types = ["${var.instance_type}"]
#   capacity_type  = "SPOT"

# }

module "eks_managed_node_group" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  cluster_service_cidr = module.eks.cluster_service_cidr
  version = "~> 20.0" # Version compatible avec AWS Provider 5.x

  name            = "${var.project}-node"
  cluster_name    = module.eks.cluster_name
  cluster_version = "1.32"

  # Utilisation directe des sorties du module VPC (plus propre que les data sources)
    subnet_ids = data.aws_subnets.private_subnets.ids

  min_size     = 1
  max_size     = 2
  desired_size = 1

  #instance_types = [var.instance_type]
  instance_types = ["${var.instance_type}"]
  capacity_type  = "SPOT"

  # Note : cluster_service_cidr n'est généralement pas requis ici 
  # car il est hérité du plan de contrôle, sauf configuration réseau spécifique.
}
