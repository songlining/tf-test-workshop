output "bucket_id" {
  description = "ID of the created S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "bucket_domain_name" {
  description = "Domain name of the created S3 bucket"
  value       = module.s3_bucket.bucket_domain_name
}