variable "vpc_id" {
    type = string
}

variable "mongo_cidrs" {
    type = list(string)
}

resource "aws_security_group" "mongo_sg" {
    name = "mongo-sg"
    description = "Allow SSH and MongoDB traffic"
    vpc_id = var.vpc_id

    ingress {
        description = "SSH from you IP"
        from_port   = 22
        to_port    = 22
        protocol   = "tcp"
        cidr_blocks = [format("%s/32", chomp(data.http.my_ip.response_body))]
    }

    ingress {
        description = "MongoDB between instances"
        from_port   = 27017
        to_port     = 27017
        protocol    = "tcp"
        cidr_blocks = var.mongo_cidrs
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "mongo-sg"
    }
}

data "http" "my_ip" {
    url = "http://checkip.amazonaws.com/"
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "mongo_key" {
    key_name = "mongo-key"
    public_key = tls_private_key.ssh.public_key_openssh
}