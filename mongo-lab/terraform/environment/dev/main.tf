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
}

module "security" {
  source       = "../../modules/security"
  vpc_id       = module.vpc.vpc_id
  mongo_cidrs  = module.vpc.public_subnet_cidrs
}

module "ec2_mongo" {
  source              = "../../modules/ec2-mongo"
  subnet_ids          = module.vpc.public_subnet_ids
  security_group_id   = module.security.mongo_sg_id
  key_name            = module.security.key_pair_name
}

resource "local_file" "private_kay" {
  content = module.security.private_key_pem
  filename = "${path.module}/mongo-key.pem"
  file_permission = "0400"
}