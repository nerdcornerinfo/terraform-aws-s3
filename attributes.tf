output "arn" {
  description = "ARN of the managed bucket."
  value       = aws_s3_bucket.this.arn
}

output "bucket_regional_domain_name" {
  description = "Bucket URL for use with CloudFront."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "id" {
  description = "Name/ID of the managed bucket."
  value       = aws_s3_bucket.this.id
}

output "operator" {
  description = "Policy document that allows operators to interact with the resource."
  value       = { json = data.aws_iam_policy_document.operator.json }
}

output "region" {
  description = "AWS region this bucket resides in."
  value       = aws_s3_bucket.this.region
}
