variable "function_name" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}

variable "memory_threshold_percent" {
  type    = number
  default = 80
}