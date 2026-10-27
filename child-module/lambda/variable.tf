variable "function_name" {
  type = string
}

variable "source_dir" {
  type        = string
  description = "Folder containing the function code"
}

variable "runtime" {
  type    = string
  default = "python3.12"
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "architectures" {
  type    = list(string)
  default = ["x86_64"]
}

variable "timeout" {
  type    = number
  default = 30
}

variable "memory_size" {
  type    = number
  default = 256
}

variable "log_retention_days" {
  type    = number
  default = 14
}

variable "insights_layer_arn" {
  type        = string
  description = "Full ARN of the Lambda Insights extension layer"
}