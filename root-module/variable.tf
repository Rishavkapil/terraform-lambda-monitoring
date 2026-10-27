variable "region" {
  type    = string
  default = "us-east-1"
}

variable "account_id" {
  type        = string
  description = "AWS account Terraform is allowed to run against"
}

variable "function_name" {
  type = string
}

variable "alert_emails" {
  type        = list(string)
  description = "Emails that receive alarm notifications"
}

variable "lambda_timeout" {
  type    = number
  default = 30
}

variable "lambda_memory" {
  type    = number
  default = 256
}

variable "insights_layer_version" {
  type        = number
  default     = 66
  description = "Lambda Insights extension layer version (x86-64, us-east-1)"
}