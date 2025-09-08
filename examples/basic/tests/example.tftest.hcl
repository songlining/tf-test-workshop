run "example_creates_resources" {
  command = plan

  assert {
    condition     = random_id.bucket_suffix.byte_length == 4
    error_message = "Random suffix should be configured with 4 bytes"
  }

  assert {
    condition     = length(local.bucket_name) > 0
    error_message = "Local bucket name should be generated"
  }
}

run "example_uses_module_correctly" {
  command = plan

  assert {
    condition     = module.s3_bucket != null
    error_message = "S3 bucket module should be instantiated"
  }
}