variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The Id of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets for the EKS cluster"
  type        = list(string)
}

variable "tags" {
  description = "Additinal tags to apply to the EKS cluster and its resources"
  type        = map(string)
}
