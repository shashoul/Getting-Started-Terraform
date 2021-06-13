terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
}

module "AWS" {
  source           = "../modules/AWS"
  alb_services     = local.conf.AWS.alb_services
  alb_response     = local.conf.AWS.alb_response
  ec2_services     = local.conf.AWS.ec2_services
  nat_services     = local.conf.AWS.nat_services
  natComp_services = local.conf.AWS.natComp_services
}

module "Kubernetes" {
  source                = "../modules/Kubernetes"
  nodesCPU_services     = local.conf.Kubernetes.nodesCPU_services
  nodesMemory_services  = local.conf.Kubernetes.nodesMemory_services
  podsCPU_services      = local.conf.Kubernetes.podsCPU_services
  containerCPU_services = local.conf.Kubernetes.containerCPU_services
  podsMemory_services   = local.conf.Kubernetes.podsMemory_services
  diskUsage_services    = local.conf.Kubernetes.diskUsage_services
}

module "MongoDB" {
  source               = "../modules/MongoDB"
  health_services      = local.conf.MongoDB.health_services
  throughput_services  = local.conf.MongoDB.throughput_services
  performance_services = local.conf.MongoDB.performance_services
  maxRes_services      = local.conf.MongoDB.maxRes_services
}

module "APM_Services" {
  source       = "../modules/APM_Services"
  apm_services = local.conf.APM_Services.apm_services
}

module "Azure" {
  source         = "../modules/Azure"
  akv_services   = local.conf.Azure.akv_services
  appgw_services = local.conf.Azure.appgw_services
  alb_services   = local.conf.Azure.alb_services
  avm_services   = local.conf.Azure.avm_services
}