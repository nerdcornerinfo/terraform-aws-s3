resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.expire_prefix

    content {
      id     = rule.key
      status = "Enabled"

      filter {
        prefix = rule.value.prefix
      }

      expiration {
        days = rule.value.days
      }
    }
  }

  dynamic "rule" {
    for_each = aws_s3_bucket_versioning.this

    content {
      id     = "expire-noncurrent"
      status = "Enabled"

      noncurrent_version_expiration {
        noncurrent_days = var.expire_versions
      }
    }
  }

  #Note: This also serves as a dummy rule for when both dynamic rules above are empty
  rule {
    id     = "clean-up-multipart"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    expiration {
      expired_object_delete_marker = true
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      #TODO add support for custom KMS key
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count = var.expire_versions == null ? 0 : 1

  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = length(data.aws_iam_policy_document.resource)

  bucket = aws_s3_bucket.this.id
  policy = one(data.aws_iam_policy_document.resource).json

  depends_on = [
    aws_s3_bucket_public_access_block.this,
  ]
}

data "aws_iam_policy_document" "resource" {
  count = var.principal != null || var.public ? 1 : 0

  statement {
    actions   = ["s3:GetObject"]
    resources = [format("%s/*", aws_s3_bucket.this.arn)]

    dynamic "condition" {
      for_each = toset([local.principal.source_arn])

      content {
        test     = "StringEquals"
        variable = "AWS:SourceArn"
        values   = [condition.value]
      }
    }

    principals {
      type        = local.principal.type
      identifiers = [local.principal.identifier]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

#restrict_public_buckets: Block public and cross-account access to buckets and objects through any
#                         public bucket or access point policies
#block_public_policy:     Block public access to buckets and objects granted through new public
#                         bucket or access point policies
#block_public_acls:       Block public access to buckets and objects granted through _new_ access
#                         control lists (ACLs)
#ignore_public_acls:      Block public access to buckets and objects granted through _any_ access#
#                         control lists (ACLs)
#See https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  restrict_public_buckets = !var.public
  block_public_policy     = !var.public
  block_public_acls       = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "this" {
  bucket = format("%s-%s", local.name, data.aws_caller_identity.this.account_id)
}

locals {
  name      = var.namespace == null ? var.name : format("%s-%s", var.namespace, var.name)
  principal = var.principal == null ? local.default_principal : var.principal

  default_principal = {
    type       = "*"
    identifier = "*"
    source_arn = null
  }
}

data "aws_caller_identity" "this" {}
