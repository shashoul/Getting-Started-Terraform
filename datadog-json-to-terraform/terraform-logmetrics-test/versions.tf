terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 2.26.0"
    }
  }
  required_version = ">= 0.13"
}
