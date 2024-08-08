variable "expire_versions" {
  default     = null
  description = "Optional days before noncurrent versions are deleted. null disables versioning. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning"
  nullable    = true
  type        = number
}

variable "expire_prefix" {
  default     = {}
  description = "Optional expire rules. Note: There can only be one aws_s3_bucket_lifecycle_configuration per bucket."
  type = map(object({
    prefix = string
    days   = number
  }))
}

variable "name" {
  description = "Identifies resource of a project uniquely within the namespace. Use $CI_PROJECT_NAME."
  nullable    = false
  type        = string
}

variable "namespace" {
  default     = null
  description = "Optional name of context owning the project. Derive from $CI_PROJECT_PATH."
  type        = string
}

variable "public" {
  default     = false
  description = "Makes the content of the bucket public. May be required by principal. Consult https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html#access-control-block-public-access-policy-status"
  type        = bool
}

variable "principal" {
  default     = null
  description = <<-EOT
  The principal that is allowed s3:GetObject on the bucket. May require public=true to work.

  Example:
  ```
  {
    type       = "Service"
    identifier = "cloudfront.amazonaws.com"
    source_arn = module.cdn.arn
  }
  ```
  EOT

  type = object({
    type       = string
    identifier = string
    source_arn = optional(string)
  })
}
