variable "container_group_name" {
  description = "Name of the container group"
  default     = "aci-container-group"
}

variable "location" {
  description = "Azure region/location"
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "my-resource-group"
}

variable "dns_name_label" {
  description = "DNS name label for the container group"
  default     = "my-container-group"
}

variable "agent_key" {
  description = "Key of the agent to associate with the autoscale setting"
  type        = string
  default = "agent1"
}

variable "agents" {
  description = "List of agent configurations"
  type        = map(object({
    name    = string
    os_type = string
    image   = string
    cpu     = number
    memory  = number
    scaling = object({
      min_instance_count                 = number
      max_instance_count                 = number
      target_cpu_utilization_percentage  = number
      cooldown_period                    = number
      scale_direction                    = string
      scale_step                         = number
    })
  }))
  default     = {
    agent1 = {
      name    = "agent1"
      os_type = "Linux"
      image   = "my-container-image"
      cpu     = 1
      memory  = 1
      scaling = {
        min_instance_count                 = 1
        max_instance_count                 = 3
        target_cpu_utilization_percentage  = 70
        cooldown_period                    = 300
        scale_direction                    = "Increase"
        scale_step                         = 1
      }
    }
  }
}

variable "autoscale_settings" {
  description = "Map of autoscale settings"
  type        = map(object({
    rules     = map(object({
      metric_name          = string
      metric_resource_id   = string
      time_grain           = string
      time_window          = string
      statistic            = string
      time_aggregation     = string
      operator             = string
      threshold            = number
      scale_actions        = map(object({
        direction = string
        cooldown  = string
        type      = string
        value     = number
      }))
    }))
    capacities       = map(object({
      min_instance_count = number
      max_instance_count = number
    }))
  }))
  default     = {}
}
