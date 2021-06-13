resource "datadog_synthetics_test" "synthetics_6_test" {

  status    = "live"
  tags      = []
  locations = ["aws:eu-west-1", ]
  message   = <<EOF
Health check for  quickstart-admins.tsec-dev.com failed
@slack-datadog-alerts @slack-transmitsecurity-datadog-alerts
EOF
  name      = "Test on quickstart-admins.tsec-dev.com/api/v2/status"
  type      = "api"
  subtype   = "http"
  request_headers = {
    Authorization = "TSToken status ;tid=status"
  }
  request_definition {
    url     = "https://quickstart-admins.tsec-dev.com/api/v2/status"
    method  = "GET"
    host    = ""
    timeout = 30
    port    = 443
  }
  assertion {
    operator = "doesNotContain"
    type     = "body"
    target   = "\"status\": 1"
  }
  assertion {
    operator = "is"
    property = "content-type"
    type     = "header"
    target   = "application/json"
  }
  assertion {
    operator = "lessThan"
    type     = "responseTime"
    target   = 3000
  }
  assertion {
    operator = "is"
    type     = "statusCode"
    target   = 200
  }
  options_list {
    min_failure_duration = 0
    monitor_options {
      renotify_interval = 0
    }
    min_location_failed = 1
    allow_insecure      = false
    tick_every          = 900
  }
}