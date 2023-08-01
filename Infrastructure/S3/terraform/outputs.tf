output "id" {
  description = "S3 bucket id"
  value       = join("", aws_s3_bucket.this[*].id)
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = join("", aws_s3_bucket.this[*].arn)
}

output "bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = join("", aws_s3_bucket.this[*].bucket_domain_name)
}

output "s3_regional_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = join("", aws_s3_bucket.this[*].bucket_regional_domain_name)
}

output "region" {
  description = "The AWS region this bucket resides in."
  value       = join("", aws_s3_bucket.this[*].region)
}
