terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}
provider "aws" {
  alias  = "Bahrain"
  region = var.region
}