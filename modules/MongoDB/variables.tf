variable "health_services" {
  type = map(object({
    framework = string,
    channel = string,
    mongodb_cpuUsage_warning  = number,
    mongodb_cpuUsage_critical = number,
    mongodb_cpuUsage_recovery = number,
    mongodb_diskUsage_warning  = number,
    mongodb_diskUsage_critical = number,
    mongodb_diskUsage_recovery = number,
    mongodb_iopsUsage_warning  = number,
    mongodb_iopsUsage_critical = number,
    mongodb_iopsUsage_recovery = number,
    mongodb_pmemUsage_warning  = number,
    mongodb_pmemUsage_critical = number,
    mongodb_pmemUsage_recovery = number,
    mongodb_connect_warning    = number,
    mongodb_connect_critical   = number,
    mongodb_connect_recovery   = number,
    }))
}

variable "throughput_services" {
  type = map(object({
    framework = string,
    channel = string,
    mongodb_readReq_warning = number,
    mongodb_readReq_critical = number,
    mongodb_readReq_recovery = number,
    mongodb_writeReq_warning  = number,
    mongodb_writeReq_critical = number,
    mongodb_writeReq_recovery = number,
    mongodb_readDocs_warning = number,
    mongodb_readDocs_critical = number,
    mongodb_readDocs_recovery = number,
    mongodb_writeDocs_warning  = number,
    mongodb_writeDocs_critical  = number,
    mongodb_writeDocs_recovery  = number,
    }))
}

variable "performance_services" {
  type = map(object({
    framework = string,
    channel = string,
    mongodb_queryExec_warning = number,
    mongodb_queryExec_critical = number,
    mongodb_queryExec_recovery = number,
    mongodb_cursor_warning = number,
    mongodb_cursor_critical = number,
    mongodb_cursor_recovery = number,
    mongodb_readOps_warning    = number,
    mongodb_readOps_critical   = number,
    mongodb_readOps_recovery   = number,
    mongodb_writeOps_warning  = number,
    mongodb_writeOps_critical = number,
    mongodb_writeOps_recovery = number,
    }))
}

variable "maxRes_services" {
  type = map(object({
    framework = string,
    channel = string,
    mongodb_mcpuUsage_warning  = number,
    mongodb_mcpuUsage_critical = number,
    mongodb_mcpuUsage_recovery = number,
    mongodb_mdiskUsage_warning  = number,
    mongodb_mdiskUsage_critical = number,
    mongodb_mdiskUsage_recovery = number,
    mongodb_hostCPU_warning = number,
    mongodb_hostCPU_critical = number,
    mongodb_hostCPU_recovery = number,
    mongodb_hostDisk_warning = number,
    mongodb_hostDisk_critical = number,
    mongodb_hostDisk_recovery = number,
    }))
}