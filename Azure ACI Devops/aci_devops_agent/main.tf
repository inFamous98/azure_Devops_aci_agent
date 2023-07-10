resource "azurerm_container_group" "aci_agent" {
  for_each            = var.agents
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_name_label      = var.dns_name_label
  os_type             = each.value.os_type

  dynamic "container" {
    for_each = [each.value]
    content {
      name   = each.key
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      environment_variables = {
        "AGENT_NAME" = each.key
      }
    }
  }
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "aci-autoscale"
  location            = var.location
  resource_group_name = var.resource_group_name
  target_resource_id  = azurerm_container_group.aci_agent[var.agent_key].id

  dynamic "profile" {
    for_each = var.autoscale_settings
    content {
      name = "profile-${profile.key}"

      dynamic "rule" {
        for_each = profile.value.rules
        content {
          metric_trigger {
            metric_name        = rule.value.metric_name
            metric_resource_id = rule.value.metric_resource_id
            time_grain         = rule.value.time_grain
            time_window        = rule.value.time_window
            statistic          = rule.value.statistic
            time_aggregation   = rule.value.time_aggregation
            operator           = rule.value.operator
            threshold          = rule.value.threshold
          }

          dynamic "scale_action" {
            for_each = rule.value.scale_actions
            content {
              direction = scale_action.value.direction
              cooldown  = scale_action.value.cooldown
              type      = scale_action.value.type
              value     = scale_action.value.value
            }
          }
        }
      }

      dynamic "capacity" {
          for_each = profile.value.capacities
          content {
            default = 1
            minimum = capacity.value.min_instance_count
            maximum = capacity.value.max_instance_count
          }
        }
    }
  }
}
