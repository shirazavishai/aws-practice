output "mongo_sg_id" {
  value = aws_security_group.mongo_sg.id
}

output "private_key_pem" {
  value = tls_private_key.ssh.private_key_pem
  sensitive = true
}

output "public_key_openssh" {
  value = tls_private_key.ssh.public_key_openssh
}

output "key_pair_name" {
  value = aws_key_pair.mongo_key.key_name
}