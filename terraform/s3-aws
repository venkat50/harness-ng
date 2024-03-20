terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  default_tags {
    tags = {
      Example = "object"
    }
  }
}


resource "aws_s3_bucket" "s3" {
  bucket = "venkat-sample"
}
