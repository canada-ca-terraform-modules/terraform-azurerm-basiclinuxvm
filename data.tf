data "azurerm_client_config" "current" {
  
}

data "azurerm_key_vault" "keyvaultsecrets" {
  name = "${var.keyvault.name}"
  resource_group_name = "${var.keyvault.resource_group_name}"
}

data "azurerm_key_vault_secret" "secretPassword" {
  name         = "${var.server.secretPasswordName}"
  key_vault_id = "${data.azurerm_key_vault.keyvaultsecrets.id}"
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.server.nic.subnetName}"
  virtual_network_name = "${var.server.nic.vnetName}"
  resource_group_name  = "${var.server.nic.resource_group_name}"
}

