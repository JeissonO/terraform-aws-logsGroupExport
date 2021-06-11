/**
  @Autor: Jeisson Osorio
  @Date: Junio 2021
  @Description: Template de configuracion de recursos para generar export de logsgroups a un bucket de S3
  INFO: Validar uso de workspace para la implementacion de la presente plantilla
  terraform workspace dev, terraform workspace qa, terraform workspace prd
**/

data "archive_file" "log_exporter" {
  type        = "zip"
  source_file = "${path.module}/lambda/function.py"
  output_path = "${path.module}/lambda/tmp/function.zip"
}
resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  number  = false
}
resource "aws_iam_role" "log_exporter" {
  name               = "${var.environment}-${var.project}-${var.resource}-role"
  assume_role_policy = local.assume_role_policy
  tags               = merge({ Name = "${var.environment}-${var.project}-${var.resource}-role" }, local.common_tags, )
}
resource "aws_iam_role_policy" "log_exporter" {
  name   = "${var.environment}-${var.project}-${var.resource}-policy"
  role   = aws_iam_role.log_exporter.id
  policy = var.policy
  tags   = merge({ Name = "${var.environment}-${var.project}-${var.resource}-policy" }, local.common_tags, )
}

resource "aws_lambda_function" "log_exporter" {
  function_name    = "${var.environment}-${var.project}-${var.resource}-job"
  filename         = data.archive_file.log_exporter.output_path
  role             = aws_iam_role.log_exporter.arn
  handler          = "function.lambda_handler"
  source_code_hash = data.archive_file.log_exporter.output_base64sha256
  timeout          = 300
  runtime          = "python3.8"
  environment {
    variables = {
      S3_BUCKET = var.export_bucket
    }
  }
  tags = merge({ Name = "${var.environment}-${var.project}-${var.resource}-job" }, local.common_tags, )
}

resource "aws_cloudwatch_event_rule" "log_exporter" {
  name                = "${var.environment}-${var.project}-${var.resource}-event"
  description         = "Fires periodically to export logs to S3"
  schedule_expression = var.schedule_expression
  tags                = merge({ Name = "${var.environment}-${var.project}-${var.resource}-event" }, local.common_tags, )
}
resource "aws_cloudwatch_event_target" "log_exporter" {
  rule      = aws_cloudwatch_event_rule.log_exporter.name
  target_id = "${var.environment}-${var.project}-${var.resource}-event"
  arn       = aws_lambda_function.log_exporter.arn
}
resource "aws_lambda_permission" "log_exporter" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log_exporter.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.log_exporter.arn
}