    resource "aws_vpc" "hub-vpc" {
      cidr_block = var.vpc_cidr
      enable_dns_hostnames = false
      enable_dns_support = true

      tags = {
        Name = "Hub-VPC-J",
        environment = var.environment,
        project-code = var.project_code,
        owner = var.owner
        managed-by = var.config_tool,
        deployed-by = var.deployed_by
      }
    }

    resource "aws_subnet" "hub-subnets" {
      count = length(var.hub_subnet_cidrs)
      vpc_id = aws_vpc.hub-vpc.id
      cidr_block = element(var.hub_subnet_cidrs, count.index)

      tags = {
        Name = "Hub-Subnet ${count.index + 1}",
        environment = var.environment,
        project-code = var.project_code,
        owner = var.owner
        managed-by = var.config_tool,
        deployed-by = var.deployed_by
      }
    }