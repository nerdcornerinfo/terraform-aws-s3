data "aws_iam_policy_document" "operator" {
  statement {
    sid       = "Overview"
    resources = ["arn:aws:s3:::*"]
    actions = [
      "s3:ListAllMyBuckets",
    ]
  }

  statement {
    resources = [aws_s3_bucket.this.arn]
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:GetMetricsConfiguration",
      "s3:ListBucket",
      "s3:ListBucketVersions",
    ]
  }

  statement {
    resources = [format("%s/*", aws_s3_bucket.this.arn)]
    actions = [
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectAttributes",
      "s3:GetObjectLegalHold",
      "s3:GetObjectRetention",
      "s3:GetObjectTagging",
      "s3:GetObjectTorrent",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionAttributes",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionTorrent",
      "s3:PutObject",
      #"s3:PutObjectAcl",
      #"s3:PutObjectAclVersion",
      #"s3:PutObjectTagging",
      #"s3:PutObjectVersionTagging",
    ]
  }
}
