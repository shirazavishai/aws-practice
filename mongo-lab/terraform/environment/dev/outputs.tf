output "mongo_public_ips" {
  value = module.ec2_mongo.public_ips
}

output "mongo_private_ips" {
  value = module.ec2_mongo.private_ips
}