locals {
  # Lambda Insights layer is published by AWS, not by your account
  insights_layer_arn = "arn:aws:lambda:${var.region}:580247275435:layer:LambdaInsightsExtension:${var.insights_layer_version}"
}

module "lambda" {
  source = "../child-module/lambda"

function_name = var.function_name
  source_dir         = "${path.root}/src"
  timeout            = var.lambda_timeout
  memory_size        = var.lambda_memory
  insights_layer_arn = local.insights_layer_arn
}

module "sns" {
  source = "../child-module/sns-alerts"

  topic_name      = "lambda-alerts"
  email_addresses = var.alert_emails
}

module "alarms" {
  source = "../child-module/lambda-alarms"

  function_name  = module.lambda.function_name
  log_group_name = module.lambda.log_group_name
  sns_topic_arn  = module.sns.topic_arn
}