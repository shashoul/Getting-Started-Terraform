######### All AKV Monitors ###########
variable "akv_services" {
  type = map(object({
    framework = string,
    channel = string,
    akv_status_warning   = number,
    akv_status_critical  = number,
    akv_apiLatency_warning = number,
    akv_apiLatency_critical = number,
    akv_apiLatency_recovery = number,
    }))
}

######### All App-GW Monitors ###########
variable "appgw_services" {
  type = map(object({
    framework = string,
    channel = string,
    app-gw_httpResponse_warning = number,
    app-gw_httpResponse_critical = number,
    app-gw_httpResponse_recovery = number,
    app-gw_backendResponse_warning = number,
    app-gw_backendResponse_critical = number,
    app-gw_backendResponse_recovery = number,
    app-gw_throughput_warning = number,
    app-gw_throughput_critical = number,
    app-gw_throughput_recovery = number,
    }))
}

######### All ALB Monitors ###########
variable "alb_services" {
  type = map(object({
    framework = string,
    channel = string,
    alb_status_warning   = number,
    alb_status_critical  = number,
    }))
}

######### All AVM Monitors ###########
variable "avm_services" {
  type = map(object({
    framework = string,
    channel = string,
    avm_cpu_warning   = number,
    avm_cpu_critical  = number,
    avm_cpu_recovery  = number,
    avm_networkIn_warning = number,
    avm_networkIn_critical = number,
    avm_networkIn_recovery = number,
    avm_networkOut_warning = number,
    avm_networkOut_critical = number,
    avm_networkOut_recovery = number,
    avm_diskRead_warning = number,
    avm_diskRead_critical = number,
    avm_diskRead_recovery = number,
    avm_diskWrite_warning = number,
    avm_diskWrite_critical = number,
    avm_diskWrite_recovery = number,
    }))
}