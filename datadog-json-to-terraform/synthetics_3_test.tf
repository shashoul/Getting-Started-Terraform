resource "datadog_synthetics_test" "synthetics_3_test" {

  status    = "paused"
  tags      = []
  locations = ["aws:eu-central-1", ]
  message   = "Notify @qa"
  name      = "Shady Terraform Test ... A Browser test on example.org"
  type      = "browser"
  browser_variable {
    pattern = "{{numeric(3)}}"
    type    = "text"
    example = "597"
    name    = "MY_PATTERN_VAR"
  }
  browser_variable {
    pattern = "jd8-afe-ydv.{{ numeric(10) }}@synthetics.dtdg.co"
    type    = "email"
    example = "jd8-afe-ydv.4546132139@synthetics.dtdg.co"
    name    = "MY_EMAIL_VAR"
  }
  browser_variable {
    type = "global"
    id   = "76636cd1-82e2-4aeb-9cfe-51366a8198a2"
    name = "MY_GLOBAL_VAR"
  }
  request_definition {
    url    = "https://app.datadoghq.com"
    method = "GET"
  }
  device_ids = ["laptop_large", ]
  options_list {
    min_location_failed = 1
    tick_every          = 3600
  }
}