terraform {
  required_version = ">= 1.3.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}