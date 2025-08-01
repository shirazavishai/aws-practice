variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  type = string
}

# Latest Ubunto 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners     = ["099720109477"] # Canonical - Ubunto publisher, safe and official

  filter { 
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]  # hardware virtualization
  }
}

resource "aws_instance" "mongo" {
    count = 2
    ami = data.aws_ami.ubuntu.id # ami - amazon machine image, the OS for the instance
    instance_type = "t2.micro"
    key_name = var.key_name # Key pair for SSH access, created in the security module

    subnet_id = element(var.subnet_ids,0) # Same subnet for both instances. For spread instances use count.index instead 0
    vpc_security_group_ids = [var.security_group_id]
    associate_public_ip_address = true

    # Runs on boot
    user_data = <<-EOF
                #!/bin/bash
                apt-get update
                apt-get install -y gnupg curl
                curl -fsSL htpps://pgp.mongodb.com/server-6.0.asc | gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor 
                echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
                apt-get update
                apt-get install -y mongodb-org
                systemctl start mongod
                systemctl enable mongod
                EOF

    tags = {
        Name = "mongo-${count.index + 1}"
    }
}