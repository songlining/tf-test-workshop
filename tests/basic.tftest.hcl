provider "aws" {
  region = "us-east-1"
}

run "valid_bucket_creation" {
  command = plan

  variables {
    bucket_name = "test-bucket-12345"
  }

  assert {
    condition     = aws_s3_bucket.this.bucket == "test-bucket-12345"
    error_message = "Bucket name did not match expected value"
  }

  assert {
    condition     = aws_s3_bucket.this.tags == null
    error_message = "Default tags should be null"
  }
}

run "bucket_with_tags" {
  command = plan

  variables {
    bucket_name = "test-bucket-with-tags"
    tags = {
      Environment = "test"
      Project     = "terraform-module"
    }
  }

  assert {
    condition = aws_s3_bucket.this.tags["Environment"] == "test"
    error_message = "Environment tag not set correctly"
  }

  assert {
    condition = aws_s3_bucket.this.tags["Project"] == "terraform-module"
    error_message = "Project tag not set correctly"
  }
}

run "outputs_are_valid" {
  command = plan

  variables {
    bucket_name = "test-outputs-bucket"
  }

  assert {
    condition     = aws_s3_bucket.this.bucket == "test-outputs-bucket"
    error_message = "Bucket name should match input"
  }
}