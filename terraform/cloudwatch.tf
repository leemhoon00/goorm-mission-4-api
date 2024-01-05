resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.namespace
  retention_in_days = 3
}
