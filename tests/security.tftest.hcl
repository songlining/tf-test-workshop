provider "aws" {
  region = "us-east-1"
}

run "encryption_is_enabled" {
  command = plan

  variables {
    bucket_name = "test-encryption-bucket"
  }

  assert {
    condition     = length(aws_s3_bucket_server_side_encryption_configuration.this.rule) > 0
    error_message = "Server-side encryption should be configured"
  }
}

run "public_access_is_blocked" {
  command = plan

  variables {
    bucket_name = "test-security-bucket"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.block_public_acls == true
    error_message = "Public ACLs should be blocked"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.block_public_policy == true
    error_message = "Public policies should be blocked"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.ignore_public_acls == true
    error_message = "Public ACLs should be ignored"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.restrict_public_buckets == true
    error_message = "Public buckets should be restricted"
  }
}

run "all_security_resources_created" {
  command = plan

  variables {
    bucket_name = "test-all-security"
  }

  assert {
    condition     = aws_s3_bucket.this != null
    error_message = "S3 bucket should be created"
  }

  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.this != null
    error_message = "Encryption configuration should be created"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this != null
    error_message = "Public access block should be created"
  }

  assert {
    condition     = aws_s3_bucket_versioning.this != null
    error_message = "Versioning configuration should be created"
  }
}