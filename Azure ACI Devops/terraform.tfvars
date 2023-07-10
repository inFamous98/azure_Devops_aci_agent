container_group_name = "my-container-group"
location             = "westus2"
resource_group_name  = "my-resource-group"
dns_name_label       = "my-container-group-dns"

agents = {
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
  agent2 = {
    name    = "agent2"
    os_type = "Windows"
    image   = "my-windows-container-image"
    cpu     = 2
    memory  = 2
    scaling = {
      min_instance_count                 = 2
      max_instance_count                 = 5
      target_cpu_utilization_percentage  = 80
      cooldown_period                    = 600
      scale_direction                    = "Decrease"
      scale_step                         = 2
    }
  }
}


autoscale_settings = {
  profile1 = {
    rules = {
      rule1 = {
        metric_name          = "metric1"
        metric_resource_id   = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.Insights/metrics/<metric_name>"
        time_grain           = "PT1M"
        time_window          = "PT5M"
        statistic            = "Average"
        time_aggregation     = "Average"
        operator             = "GreaterThan"
        threshold            = 10
        scale_actions = {
          action1 = {
            direction = "Increase"
            cooldown  = "PT5M"
            type      = "ChangeCount"
            value     = 1
          }
        }
      }
    }
    capacities = {
      capacity1 = {
        min_instance_count = 1
        max_instance_count = 10
      }
    }
  }
}
