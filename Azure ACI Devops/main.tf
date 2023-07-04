module "aci_devops_agents" {
  source              = "./aci_devops_agent"
  location            = var.location
  resource_group_name = var.resource_group_name
  agents              = var.agents
}