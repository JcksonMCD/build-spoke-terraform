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