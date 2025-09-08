terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

locals {
  bucket_name = var.bucket_name != "" ? var.bucket_name : "my-example-bucket-${random_id.bucket_suffix.hex}"
}

module "s3_bucket" {
  source = "../../"

  bucket_name       = local.bucket_name
  enable_versioning = var.enable_versioning

  tags = {
    Environment = "example"
    Purpose     = "terraform-module-demo"
  }
}