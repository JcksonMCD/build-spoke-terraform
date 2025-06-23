    output "hub_vpc_id" {
      value = aws_vpc.hub-vpc.id
      description = "Value of the Hub VPC ID"
    }

    output "hub_subnet_ids" {
        value = aws_subnet.hub-subnets[*].id
        description = "All Hub Subnet ID's"
    }

    output "hub_lambda_arns" {
        value = aws_lambda_function.hub-lambdas[*].arn
        description = "All Hub Lambda ARN's"
    }

    output "lambda_role_arn" {
        value = aws_iam_policy.lambda.arn
        description = "Lambda IAM role ARN"
    }