    terraform {
      required_version =">= 1"
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = ">= 6.0"
        }
      }
    }

    provider "aws" {
        region = "eu-west-2"
    }