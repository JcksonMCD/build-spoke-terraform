    output "hub_vpc_id" {
      value = aws_vpc.hub-vpc.id
      description = "Value of the Hub VPC ID"
    }