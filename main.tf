terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

# Default region specified as us-west-2
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}