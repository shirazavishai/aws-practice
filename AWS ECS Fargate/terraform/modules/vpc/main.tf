resource "aws_vpc" "vpc" {
    cidr_block = 10.0.0.0/16
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "vpc"
    }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
}


# resource "aws_subnet" "public_subnet_1" {
#     cidr_block = 10.0.1.0/24
#     vpc_id = aws_vpc.vpc.id
#     availability_zone = "us-east-1a"
#     map_public_ip_on_launch = true
#     tags = {
#         Name = "public-subnet-1"
#     }
# }
# 
# resource "aws_subnet" "public_subnet_2" {
#     cidr_block = 10.0.2.0/24
#     vpc_id = aws_vpc.vpc.id
#     availability_zone = "us-east-1b"
#     map_public_ip_on_launch = true
#     tags = {
#         Name = "public-subnet-2"
#     }
# }

