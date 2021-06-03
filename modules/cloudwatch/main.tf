resource "aws_cloudwatch_log_group" "logs" {
  name              = var.name
  retention_in_days = var.retention_in_days
}
