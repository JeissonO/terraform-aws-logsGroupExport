output "invoke_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
  value       = aws_lambda_function.log_exporter.invoke_arn
}
output "lambda_arn" {
  description = "Amazon Resource Name (ARN) identifying your Lambda Function"
  value       = aws_lambda_function.log_exporter.arn
}
output "event_id" {
  description = "The name of the rule."
  value       = aws_cloudwatch_event_rule.log_exporter.id
}
output "event_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = aws_cloudwatch_event_rule.log_exporter.arn
}
