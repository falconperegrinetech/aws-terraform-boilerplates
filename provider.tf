terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
    bucket = "falcon-vpc-boilerplate"
    key    = "state.tfstate"
    region = "us-west-2"
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region = var.region
}

