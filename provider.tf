terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
    backend "s3" {
    bucket = "terraform-state-goobie"
    key    = "state"
    region = "us-west-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "veup"
}