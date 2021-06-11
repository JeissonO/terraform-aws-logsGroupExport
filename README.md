# terraform-aws-logsGroupExport

This module creates resources that fire events to export your logs groups in Cloudwatch to an S3 Bucket


## Content

- [terraform-aws-logsGroupExport](#terraform-aws-logsgroupexport)
  - [Content](#content)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)




<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.log_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.log_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.log_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.log_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.log_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.log_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [archive_file.log_exporter](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment where you are working and where the resources going to be created | `string` | `"sandbox"` | no |
| <a name="input_export_bucket"></a> [export\_bucket](#input\_export\_bucket) | Bucket to export logs | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization or entity owner of these resources | `string` | `"poc"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project owner of these resources | `string` | `"tanok"` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | Name to identify resources | `string` | `"logsgroup-exporter"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes) | `string` | `"rate(4 hours)"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_arn"></a> [event\_arn](#output\_event\_arn) | The Amazon Resource Name (ARN) of the rule. |
| <a name="output_event_id"></a> [event\_id](#output\_event\_id) | The name of the rule. |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri. |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function |
<!-- END_TF_DOCS -->