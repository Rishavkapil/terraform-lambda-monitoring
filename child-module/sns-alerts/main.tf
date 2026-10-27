resource "aws_sns_topic" "alerts" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "email" {
  for_each = toset(var.email_addresses)

  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = each.value
}