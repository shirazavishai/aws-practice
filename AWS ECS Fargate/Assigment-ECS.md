# 🧪 DevOps Practice Assignment: Scalable MongoDB Deployment on AWS ECS Fargate

* ECS - Elastic Container Service

## 📝 Objective
Design and deploy a highly available, containerized MongoDB cluster on AWS using ECS Fargate. The system should run two MongoDB instances, designed for resilience and scalability, using modern AWS-native and infrastructure-as-code practices.

## 📦 Requirements

### 🔧 Infrastructure (via Terraform):
- **VPC** with at least 2 public subnets across 2 availability zones.
- **Security Group** that:
  - Allows incoming MongoDB connections (default port `27017`) from your IP.
  - Allows traffic between the MongoDB containers.
- **Elastic Container Service (ECS):**
  - An ECS cluster running on Fargate.
  - A Task Definition using a MongoDB Docker image.
  - A Service with 2 tasks (MongoDB containers) deployed in separate AZs.
- **Elastic File System (EFS)** (optional but preferred):
  - Mount EFS to both tasks to support data persistence.
- **(Optional) Application Load Balancer (ALB):**
  - Setup health checks to monitor task health.
  - Useful if you're exposing MongoDB for development/testing.

### 🔁 Scalability Requirements
- ECS Service must be deployed with `desired_count = 2`.
- Tasks should be distributed across AZs.
- Configure Service Auto Scaling (optional stretch goal).

## 📁 Deliverables
- **Terraform code** structured as:
  ```
  terraform/
  └── modules/
      ├── vpc/
      ├── ecs/
      ├── efs/         (optional)
      ├── security/
  └── environment/
      └── dev/
          ├── main.tf
          ├── variables.tf
          └── terraform.tfvars
  ```
- **MongoDB ECS Task Definition:**
  - Use official MongoDB image (or lightweight `mongo:6` version).
  - Set memory/CPU limits appropriately for small-scale deployment.
- **README.md** with:
  - Deployment steps.
  - How to connect to MongoDB.
  - How to scale the service.

## 🚀 Bonus (Stretch Goals)
- Configure auto-scaling of the ECS service based on CPU or memory usage.
- Attach CloudWatch Logs to see MongoDB logs from containers.
- Use Terraform remote backend (e.g., S3 + DynamoDB) for state management.

## 📚 Suggested References
- [MongoDB Docker Hub](https://hub.docker.com/_/mongo)
- [AWS ECS Fargate + Terraform Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service)
- [AWS EFS Integration with ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_efs.html)

