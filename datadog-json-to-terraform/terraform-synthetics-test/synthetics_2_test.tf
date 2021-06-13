resource "datadog_synthetics_test" "synthetics_2_test" {

  status    = "live"
  tags      = ["environment:development", ]
  locations = ["aws:eu-west-1", ]
  message   = "Health check for  ingress-test-2.tsec-dev.com failed @slack-d-m_eus-ingress-test-2"
  name      = "Shady Terraform Test ... Test on ingress-test-2.tsec-dev.com/api/v2/status"
  type      = "api"
  subtype   = "http"
  request_headers = {
    Authorization = "TSToken status ;tid=status"
  }
  request_definition {
    url     = "https://ingress-test-2.tsec-dev.com/api/v2/status"
    body    = ""
    method  = "GET"
    timeout = 30
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
    operator = "is"
    type     = "statusCode"
    target   = 200
  }
  assertion {
    operator = "lessThan"
    type     = "responseTime"
    target   = 3000
  }
  options_list {
    follow_redirects     = false
    min_failure_duration = 0
    tick_every           = 900
    min_location_failed  = 1
  }
}