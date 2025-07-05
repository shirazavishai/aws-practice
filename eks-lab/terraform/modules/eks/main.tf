module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.2"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnet_ids

  enable_irsa = true

  eks_managed_node_groups = {
    on_demand = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
    spot = {
      instance_types = ["t3.medium", "t3a.medium"]
      capacity_type  = "SPOT"
      min_size       = 0
      max_size       = 3
      desired_size   = 1
    }
  }

  tags = var.tags
}
