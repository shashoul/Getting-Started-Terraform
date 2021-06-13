resource "datadog_monitor" "clock_sync_ntp_monitor" {

  name    = "Shady Terraform Test !!! [Auto] Clock in sync with NTP"
  type    = "service check"
  query   = "'ntp.in_sync'.over('*').last(2).count_by_status()"
  message = <<EOF
Triggers if any host's clock goes out of sync with the time given by NTP. The offset threshold is configured in the Agent's `ntp.yaml` file.

Please read the [KB article](https://docs.datadoghq.com/agent/faq/network-time-protocol-ntp-offset-issues) on NTP Offset issues for more details on cause and resolution.
EOF
  tags    = []
  monitor_thresholds {
    warning  = 1
    ok       = 1
    critical = 1
  }
  priority = null
}