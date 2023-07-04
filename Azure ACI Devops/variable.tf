variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "agents" {
  description = "The configurations for the ACI DevOps agents."
  type        = map(object({
    os_type = string
    image   = string
    cpu     = number
    memory  = number
    port    = number
  }))
}
