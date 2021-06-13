resource "datadog_monitor" "azure_akv_monitor" {

  name                = "Shady Terraform test ... - Azure AKV - Status"
  type                = "query alert"
  query               = "avg(last_1h):avg:azure.keyvault_vaults.status{*} < 0"
  message             = "Azure Key Vault is down. @slack-cloud-alerts-dev-test"
  tags                = []
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical = 0
    warning  = 0.5
  }
  priority = null
}