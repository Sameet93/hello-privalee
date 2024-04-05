variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "privilee"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "me-south-1"
}

variable "name" {
  description = "The name of the node group"
  type        = string
  default     = "privilee-app"
}

variable "instance_types" {
  description = "The instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}