resource "aws_api_gateway_rest_api" "hub-api" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "Hub API Gateway"
      version = "1.0"
    }
    paths = {
      ("/lambda1") = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "2.0"
            type                 = "AWS_PROXY"
            uri                  = aws_lambda_function.hub-lambdas["lambda1"].invoke_arn
          }
        }
      },
      ("/lambda2") = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "2.0"
            type                 = "AWS_PROXY"
            uri                  = aws_lambda_function.hub-lambdas["lambda2"].invoke_arn
          }
        }
      }
    }
  })

  name = "Hub API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_lambda_permission" "apigw_lambda1" {
  statement_id  = "AllowAPIGatewayInvokeLambda1"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hub-lambdas["lambda1"].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.hub-api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_lambda2" {
  statement_id  = "AllowAPIGatewayInvokeLambda2"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hub-lambdas["lambda2"].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.hub-api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "hub-api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.hub-api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.hub-api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "hub-api-stage" {
  deployment_id = aws_api_gateway_deployment.hub-api-deployment.id
  rest_api_id   = aws_api_gateway_rest_api.hub-api.id
  stage_name    = "hub-api-stage"
}

resource "aws_api_gateway_method_settings" "api-method-settings" {
  rest_api_id = aws_api_gateway_rest_api.hub-api.id
  stage_name  = aws_api_gateway_stage.hub-api-stage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
  }
}