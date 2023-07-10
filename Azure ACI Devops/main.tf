module "aci_devops_agents" {
  source = "./aci_devops_agent"

  container_group_name = var.container_group_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  dns_name_label       = var.dns_name_label
  agents               = var.agents
  autoscale_settings   = var.autoscale_settings
}
