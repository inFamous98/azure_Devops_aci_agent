resource "azurerm_container_group" "aci_agents" {
  for_each            = var.agents
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = each.value.os_type
  dns_name_label      = each.key
  restart_policy      = "Always"
  
  container {
    name   = each.key
    image  = each.value.image
    cpu    = each.value.cpu
    memory = each.value.memory
  
    ports {
      port     = each.value.port
      protocol = "TCP"
    }
  }

  ip_address_type = "Public"
}
