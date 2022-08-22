terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.1"
    }
  }
  backend "s3" {
    bucket = "aws-terraform-boilerplates-state"
    key    = "state.tfstate"
    region = "us-west-2"
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region = var.region
}

