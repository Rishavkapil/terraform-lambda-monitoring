# ---------- Timeouts (log metric filter + alarm) ----------
resource "aws_cloudwatch_log_metric_filter" "timeouts" {
  name           = "${var.function_name}-timeouts"
  log_group_name = var.log_group_name
  pattern        = "?\"Status: timeout\" ?\"Task timed out\""

  metric_transformation {
    name          = "${var.function_name}-Timeouts"
    namespace     = "Custom/Lambda"
    value         = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "timeouts" {
  alarm_name          = "${var.function_name}-timeouts"
  namespace           = "Custom/Lambda"
  metric_name         = "${var.function_name}-Timeouts"
  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [var.sns_topic_arn]

  depends_on = [aws_cloudwatch_log_metric_filter.timeouts]
}

# ---------- Memory (Lambda Insights) ----------
resource "aws_cloudwatch_metric_alarm" "memory" {
  alarm_name          = "${var.function_name}-memory-high"
  namespace           = "LambdaInsights"
  metric_name         = "memory_utilization"
  dimensions          = { function_name = var.function_name }
  statistic           = "Maximum"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.memory_threshold_percent
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [var.sns_topic_arn]
}