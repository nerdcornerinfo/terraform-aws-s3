<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_expire_prefix"></a> [expire\_prefix](#input\_expire\_prefix) | Optional expire rules. Note: There can only be one aws\_s3\_bucket\_lifecycle\_configuration per bucket. | <pre>map(object({<br>    prefix = string<br>    days   = number<br>  }))</pre> | `{}` | no |
| <a name="input_expire_versions"></a> [expire\_versions](#input\_expire\_versions) | Optional days before noncurrent versions are deleted. null disables versioning. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Identifies resource of a project uniquely within the namespace. Use $CI\_PROJECT\_NAME. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Optional name of context owning the project. Derive from $CI\_PROJECT\_PATH. | `string` | `null` | no |
| <a name="input_principal"></a> [principal](#input\_principal) | The principal that is allowed s3:GetObject on the bucket. May require public=true to work.<br><br>Example:<pre>{<br>  type       = "Service"<br>  identifier = "cloudfront.amazonaws.com"<br>  source_arn = module.cdn.arn<br>}</pre> | <pre>object({<br>    type       = string<br>    identifier = string<br>    source_arn = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_public"></a> [public](#input\_public) | Makes the content of the bucket public. May be required by principal. Consult https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html#access-control-block-public-access-policy-status | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the managed bucket. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | Bucket URL for use with CloudFront. |
| <a name="output_id"></a> [id](#output\_id) | Name/ID of the managed bucket. |
| <a name="output_operator"></a> [operator](#output\_operator) | Policy document that allows operators to interact with the resource. |
| <a name="output_region"></a> [region](#output\_region) | AWS region this bucket resides in. |
<!-- END_TF_DOCS -->