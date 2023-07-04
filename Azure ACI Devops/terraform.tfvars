location            = "eastus"
resource_group_name = "my-resource-group"

agents = {
  agent1 = {
    os_type = "Linux"
    image   = "mcr.microsoft.com/azure-devops/agent:ubuntu-18.04"
    cpu     = 1
    memory  = 2
    port    = 80
  }
  agent2 = {
    os_type = "Windows"
    image   = "mcr.microsoft.com/azure-devops/agent:windows-2019"
    cpu     = 2
    memory  = 4
    port    = 8080
  }
}
