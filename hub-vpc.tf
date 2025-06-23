    resource "aws_vpc" "hub-vpc" {
      cidr_block = var.vpc_cidr
      enable_dns_hostnames = false
      enable_dns_support = true

      tags = merge(
        {
          Name = "Hub VPC J"
        },
        local.common_tags
      )
    }

    resource "aws_subnet" "hub-subnets" {
      count = length(var.hub_subnet_cidrs)
      vpc_id = aws_vpc.hub-vpc.id
      cidr_block = element(var.hub_subnet_cidrs, count.index)

      tags = merge(
        {
          Name = "Hub-Subnet ${count.index + 1}"
        },
        local.common_tags
      )
    }

    resource "aws_security_group" "lambda_sg" {
      name        = "lambda-security-group"
      description = "Security group for Lambda functions"
      vpc_id      = aws_vpc.hub-vpc.id

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags = merge(
        {
          Name = "Hub Security Group"
        },
        local.common_tags
      )
    }