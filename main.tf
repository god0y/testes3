terraform {
  required_version = ">= 1.2.0"
  cloud {
    organization = "jefersongalhardi"
    workspaces {
      name = "S3"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
