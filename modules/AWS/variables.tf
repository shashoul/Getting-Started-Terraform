######### All ALB Variables ###########
variable "alb_services" {
  type = map(object({
    framework = string,
    channel = string,
    alb_totalReqCount_warning = number,
    alb_totalReqCount_critical = number,
    alb_totalReqCount_recovery = number,
    alb_4xx_httpcode_warning = number,
    alb_4xx_httpcode_critical = number,
    alb_4xx_httpcode_recovery = number,
    }))
}

variable "alb_response" {
  type = map(object({
    framework = string,
    channel = string,
    alb_responseTime_avg_warning   = number,
    alb_responseTime_avg_critical  = number,
    alb_responseTime_avg_recovery  = number,
    }))
}

######### All EC2 Variables ###########
variable "ec2_services" {
  type = map(object({
    framework = string,
    channel = string,
    ec2_cpu_avg_warning   = number,
    ec2_cpu_avg_critical  = number,
    ec2_cpu_avg_recovery  = number,
    ec2_cpu_max_warning   = number,
    ec2_cpu_max_critical  = number,
    ec2_cpu_max_recovery  = number,
    ec2_networkIn_avg_warning  = number,
    ec2_networkIn_avg_critical = number,
    ec2_networkIn_avg_recovery = number,
    ec2_networkOut_avg_warning = number,
    ec2_networkOut_avg_critical = number,
    ec2_networkOut_avg_recovery = number,
    ec2_networkOut_max_warning = number,
    ec2_networkOut_max_critical = number,
    ec2_networkOut_max_recovery = number,
    ec2_networkIn_max_warning = number,
    ec2_networkIn_max_critical = number,
    ec2_networkIn_max_recovery = number,
    }))
}

######### All NAT Variables ###########
variable "nat_services" {
  type = map(object({
    framework = string,
    channel = string,
    nat_activeConnection_count_warning = number,
    nat_activeConnection_count_critical = number,
    nat_activeConnection_count_recovery = number,
  }))
}

variable "natComp_services" {
  type = map(object({
    framework = string,
    channel = string,
    natComp_byteOut_clients_warning = number,
    natComp_byteOut_clients_critical = number,
    natComp_byteOut_clients_recovery =number,
    natComp_byteIn_dest_warning = number,
    natComp_byteIn_dest_critical = number,
    natComp_byteIn_dest_recovery = number,
   })) 
}