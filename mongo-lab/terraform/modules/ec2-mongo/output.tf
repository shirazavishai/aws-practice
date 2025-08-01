output "public_ips" {
    value = aws_instance.mongo[*].public_ip
}

output "private_ips" {
    value = aws_instance.mongo[*].private_ip
}