    locals {
    common_tags = {
        environment  = var.environment,
        project-code = var.project_code,
        owner        = var.owner,
        managed-by   = var.config_tool,
        deployed-by  = var.deployed_by
    }
    }
    
    variable "environment" {
        type = string
        default = "development"
        description = "Environment name"
    }

    variable "project_code" {
        type = string
        default = "ADO-ACA026"
        description = "Project billing code"
    }

    variable "deployed_by" {
        type = string
        default = "Jackson M"
        description = "Deployed by"
    }

    variable "owner" {
        type = string
        default = "jackson.macdonald@answerdigital.com"
        description = "Resource owner"
    }

    variable "config_tool" {
        type = string
        default = "Terraform"
        description = "Configuration Tool used for setup"
    }

    variable "vpc_cidr" {
        type = string
        default = "10.10.0.0/20"
        description = "CIDR block for the VPC"

      validation {
        condition = anytrue([can(regex("10(?:\\.(?:[0-1]?[0-9]?[0-9])|(?:2[0-5]?[0-9])){3}\\/", var.vpc_cidr)), can(regex("172\\.(?:3?[0-1])|(?:[0-2]?[0-9])(?:\\.[0-2]?[0-5]?[0-9]){2}\\/(?:1[6-9]|2[0-9]|3[0-2])", var.vpc_cidr))])
        error_message = "Must be a valid IP CIDR range of the form x.x.x.x/x."
      }
    }

    variable "hub_subnet_cidrs" {
        type        = list(string)
        description = "Subnet CIDR values"
        default     = ["10.10.10.0/24", "10.10.11.0/24"]
    }

    variable "lambda_functions" {
    default = {
        lambda1 = {
        name        = "lambda-function-1"
        handler     = "lambda1.lambda_handler"
        runtime     = "python3.11"
        source_path = "hub-lambda/lambda1.zip"
        }
        lambda2 = {
        name        = "lambda-function-2"
        handler     = "lambda2.lambda_handler"
        runtime     = "python3.11"
        source_path = "hub-lambda/lambda2.zip"
        }
    }
    }