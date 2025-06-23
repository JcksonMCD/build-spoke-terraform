    resource "aws_lambda_function" "hub-lambdas" {
    for_each = var.lambda_functions

    function_name = each.value.name
    handler       = each.value.handler
    runtime       = each.value.runtime
    role          = aws_iam_role.lambda.arn
    filename      = each.value.source_path

    vpc_config {
        subnet_ids         = aws_subnet.hub-subnets[*].id
        security_group_ids = [aws_security_group.lambda_sg.id]
    }

    source_code_hash = filebase64sha256(each.value.source_path)
    }

    resource "aws_iam_role" "lambda" {
      name        = "HubLambdaRole"
      description = "Allows Lambda functions to call AWS services on your behalf."

      assume_role_policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Service" : "lambda.amazonaws.com"
            },
            "Action" : [
                "sts:AssumeRole"
            ]
          }
        ]
      })
      
    }

    resource "aws_iam_policy" "lambda_vpc_access" {
    name = "LambdaVPCAccessPolicy"

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Effect = "Allow",
            Action = [
            "ec2:CreateNetworkInterface",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteNetworkInterface"
            ],
            Resource = "*"
        }
        ]
    })
    }

    resource "aws_iam_role_policy_attachment" "lambda_vpc_access_attach" {
    role       = aws_iam_role.lambda.name
    policy_arn = aws_iam_policy.lambda_vpc_access.arn
    }
