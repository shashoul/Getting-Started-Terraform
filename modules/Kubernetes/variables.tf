######### All Nodes CPU Variables ###########
variable "nodesCPU_services" {
  type = map(object({
     framework = string,
     channel = string,
     kubernetes_cpu_usage_warning = number,
     kubernetes_cpu_usage_critical = number,
     kubernetes_cpu_usage_recovery = number,
    }))
}
######### All Pods CPU Variables ###########
variable "podsCPU_services" {
  type = map(object({
    framework = string,
    channel = string,
    kubernetes_cpu_usage_warning = number,
    kubernetes_cpu_usage_critical = number,
    kubernetes_cpu_usage_recovery = number,
    }))
}
######### All Container CPU Variables ###########
variable "containerCPU_services" {
  type = map(object({
    framework = string,
    channel = string,
    kubernetes_cpu_usage_warning = number,
    kubernetes_cpu_usage_critical = number,
    kubernetes_cpu_usage_recovery = number,
    }))
}
######### All Nodes Memory Variables ###########
variable "nodesMemory_services" {
  type = map(object({
    framework = string,
    channel = string,
    kubernetes_memory_usage_warning = number,
    kubernetes_memory_usage_critical = number,
    kubernetes_memory_usage_recovery = number,
    }))
}
######### All Pods Memory Variables ###########
variable "podsMemory_services" {
  type = map(object({
    framework = string,
    channel = string,
    kubernetes_memory_usage_warning  = number,
    kubernetes_memory_usage_critical = number,
    kubernetes_memory_usage_recovery = number,
    kubernetes_freeMemory_capacity_warning  = number,
    kubernetes_freeMemory_capacity_critical = number,
    kubernetes_freeMemory_capacity_recovery = number,
    }))
}
######### All Nodes Disk Usage Variables ###########
variable "diskUsage_services" {
  type = map(object({
    framework = string,
    channel = string,
    kubernetes_diskUsage_warning  = number,
    kubernetes_diskUsage_critical = number,
    kubernetes_diskUsage_recovery = number,
    }))
}