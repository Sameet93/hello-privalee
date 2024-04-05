data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id                         = data.aws_vpc.default.id
  subnet_ids                     = toset(data.aws_subnets.default.ids)
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    privilee-app = {
      name = "privilee-app"

      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 6
      desired_size = 2
    }
  }
}
