terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "local" {
   path = "terraform.tfstate"
 }
}
provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "s3" {
  bucket = "venkat-sample"
}
