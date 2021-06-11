########################
### Variables Inputs  ##
########################
variable "environment" {
  description = "The environment where you are working and where the resources going to be created"
  type        = string
  default     = "sandbox"
}
variable "organization" {
  description = "Organization or entity owner of these resources"
  type        = string
  default     = "poc"
}
variable "project" {
  description = "Project owner of these resources"
  type        = string
  default     = "tanok"
}
variable "resource" {
  description = "Name to identify resources"
  type        = string
  default     = "logsgroup-exporter"
}
variable "schedule_expression" {
  type        = string
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)"
  default     = "rate(4 hours)"
}
variable "export_bucket" {
  type        = string
  description = "Bucket to export logs"
}
locals {
  common_tags = (tomap({
    Environment  = var.environment
    Organization = var.organization
    Project      = var.project
  }))
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Sid": ""
        }
    ]    
}
EOF
  policy             = <<EOF
{    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateExportTask",
                "logs:Describe*",
                "logs:ListTagsLogGroup",
                "ssm:DescribeParameters",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:GetParametersByPath",
                "ssm:PutParameter",
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:logs:*:*:*"
        }
    ]    
}
EOF
}
