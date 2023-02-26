############ Input variable definitions ############
variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "create_trail" {
  description = "Set to false if a Cloudtrail trail for management events exists"
  type        = bool
  default     = true
}

variable "autotag_function_name" {
  description = "Name of lambda function"
  type        = string
  default     = "add_tag_rds"
}

variable "autotag_description" {
  description = "Name of lambda function"
  type        = string
  default     = "Add tags on RDS Instance and Aurora Cluster"
}

variable "lambda_tag_key" {
  description = "Lambda Tag Key"
  type        = string
  default     = "squad"
}

variable "lambda_tag_value" {
  description = "Lambda Tag Key"
  type        = string
  default     = "dba"
}