    resource "aws_vpc" "hub-vpc-j" {
      cidr_block = var.vpc_cidr
      enable_dns_hostnames = false
      enable_dns_support = true

      tags = {
        Name = "VPC",
        environment = var.environment,
        project-code = var.project_code,
        owner = var.owner
        managed-by = var.config_tool,
        deployed-by = var.deployed_by
      }
    }