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

variable "azure_devops_org_name" {
  description = "The name of the Azure DevOps organization."
  type        = string
  default     = ""
}

variable "azure_devops_personal_access_token" {
  description = "The personal access token for Azure DevOps."
  type        = string
  default     = ""
}
