terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40" # ✅ safe version that supports EKS module
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
  vpc_name = "eks-lab-vpc"
  region   = "us-east-1"
  vpc_cidr = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  tags = {
    Project = "eks-lab"
    Env     = "dev"
  }
}
