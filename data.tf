data "azurerm_subnet" "subnet" {
  depends_on           = [var.nic_depends_on]
  name                 = var.nic_subnetName
  virtual_network_name = var.nic_vnetName
  resource_group_name  = var.nic_resource_group_name
}

data "azurerm_resource_group" "resourceGroup" {
  depends_on = [var.nic_depends_on]
  name       = var.resource_group_name
}
