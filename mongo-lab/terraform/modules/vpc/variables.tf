variable "vpc_name" {
  description = "The name of the VPC to create"
  type        = string
}

variable "region" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags to apply to the VPC and its resources"
  type        = map(string)
}
