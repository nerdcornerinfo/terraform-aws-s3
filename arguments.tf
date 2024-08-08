variable "expire_versions" {
  description = "Optional days before noncurrent versions are deleted. null disables versioning. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning"
  type        = number
  nullable    = true
  default     = null
}

variable "expire_prefix" {
  description = "Optional expire rules. Note: There can only be one aws_s3_bucket_lifecycle_configuration per bucket."
  default     = {}
  type = map(object({
    prefix = string
    days   = number
  }))
}

variable "name" {
  description = "The name of the project owning the bucket."
  type        = string
  nullable    = false
}

variable "namespace" {
  description = "Optional name of the group owning the project. This helps distinguish projects with similar names but different owners."
  type        = string
  default     = null
}

variable "public" {
  description = "Makes the content of the bucket public. May be required by principal. Consult https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html#access-control-block-public-access-policy-status"
  type        = bool
  default     = false
}

variable "principal" {
  description = "The principal that is allowed s3:GeObject on the bucket, i.e. type=Service, identifier=cloudfront.amazonaws.com, source_arn=module.cdn.arn. May require public=true to work."
  type = object({
    type       = string
    identifier = string
    source_arn = optional(string)
  })
  default = null
}
