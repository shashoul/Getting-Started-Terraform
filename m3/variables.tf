##################################################################################
# VARIABLES
##################################################################################

variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-east-1"
}
variable "vpc_id" {
  default = "vpc-07b7228813661529f"
}
variable "subnet_id" {
  default = "subnet-0eca4826b4869b449"
}
variable "bucket_name_prefix" {}
variable "billing_code_tag" {}
variable "environment_tag" {}

##################################################################################
# LOCALS
##################################################################################

locals {
  common_tags = {
    BillingCode = var.billing_code_tag
    Environment = var.environment_tag
  }

  s3_bucket_name = "${var.bucket_name_prefix}-${var.environment_tag}-${random_integer.rand.result}"
  s3_bucket_name_module = "${var.bucket_name_prefix}-${var.environment_tag}-${random_integer.rand.result}-module"
}