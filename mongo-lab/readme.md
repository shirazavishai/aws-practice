1. Create modules
1. Output necessary variables
1. Declare variable before using in modules

1. terraform init
1. terraform plan
1. terraform apply

### Adding key-pair to existing EC2
1. Must delete. Cannot update existing instance
1. Add key-pair to terraform
1. check - terraform plan
1. destroy existing inatsnce -  terraform destroy -target="module.ec2_mongo.aws_instance.mongo[0]" -target="module.ec2_mongo.aws_instance.mongo[1]"
1. terraform plan
1. terraform apply


### Additional terraform files
.terraform/ | Holds downloaded provider plugins, modules, and internal config/cache
.terrafor.lock.hcl | Lock provider versions for repoducible builds (safe to commit)
terraform.tfstate | Tracks the currnt state of your infrastructure (never commit)
terraform.tfstate.backup | Backup of the previous state before last succesful apply (never commit)