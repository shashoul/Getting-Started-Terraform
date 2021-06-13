variable "apm_services" {
  type = map(object({
    environment = string,
    framework = string,
    channel = string,
    high_avg_latency_critical = number,
    high_avg_latency_warning  = number,
    high_p95_latency_critical = number,
    high_p95_latency_warning  = number,
    high_error_rate_critical  = number,
    high_error_rate_warning   = number,
    }))
}