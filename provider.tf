provider "aws" {
  region  = local.env.region
  profile = local.env.profile
}

terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    profile = "test"
    bucket  = "test-tfstate"
    key     = "test/terraform.tfstate"
    region  = "ap-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.8.0"
    }
  }
}
