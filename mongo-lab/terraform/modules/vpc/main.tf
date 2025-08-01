resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"     # Ip range for all inastances in this VPC
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "mongo-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id      # Attaches the IGW to the VPC 

  tags = {
    Name = "mongo-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mongo-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                       # Match all traffic
    gateway_id = aws_internet_gateway.igw.id       # Send external traffic to the IGW
  }

  tags = {
    Name = "mongo-public-rt"
  }
}

resource "aws_route_table_association" "public" {    
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id          # Binds subnet to route table
}