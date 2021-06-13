terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 2.21.0"
    }
  }
  required_version = ">= 0.13"
}