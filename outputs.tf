    output "hub_vpc_id" {
      value = aws_vpc.hub-vpc.id
      description = "Value of the Hub VPC ID"
    }

    output "hub_subnet_ids" {
        value = aws_subnet.hub-subnets[*].id
        description = "All Hub Subnet ID's"
    }