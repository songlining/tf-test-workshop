provider "aws" {
  region = "us-east-1"
}

run "versioning_disabled_by_default" {
  command = plan

  variables {
    bucket_name = "test-versioning-default"
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Suspended"
    error_message = "Versioning should be disabled by default"
  }
}

run "versioning_enabled_when_set" {
  command = plan

  variables {
    bucket_name       = "test-versioning-enabled"
    enable_versioning = true
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Enabled"
    error_message = "Versioning should be enabled when enable_versioning is true"
  }
}

run "versioning_explicitly_disabled" {
  command = plan

  variables {
    bucket_name       = "test-versioning-disabled"
    enable_versioning = false
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Suspended"
    error_message = "Versioning should be suspended when enable_versioning is false"
  }
}