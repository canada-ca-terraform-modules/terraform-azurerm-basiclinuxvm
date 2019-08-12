terraform {
  required_version = ">= 0.12.1"
}
provider "azurerm" {
  version = ">= 1.32.0"
}

locals {
  template_name = "basiclinuxvm"
}


data "azurerm_client_config" "current" {}

data "template_file" "cloudconfig" {
  template = "${file("serverconfig/test-init.sh")}"
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content = "${data.template_file.cloudconfig.rendered}"
  }
}

module "test-basiclinuxvm" {
  source = "../."

  name                    = "test1"
  resource_group_name     = "${azurerm_resource_group.test-RG.name}"
  admin_username          = "azureadmin"
  secretPasswordName      = "${azurerm_key_vault_secret.serverPassword.name}"
  custom_data             = "${data.template_cloudinit_config.config.rendered}"
  nic_subnetName          = "${azurerm_subnet.subnet1.name}"
  nic_vnetName            = "${azurerm_virtual_network.test-VNET.name}"
  nic_resource_group_name = "${azurerm_resource_group.test-RG.name}"
  vm_size                 = "Standard_B1s"
  storage_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  keyvault = {
    name                = "${azurerm_key_vault.test-keyvault.name}"
    resource_group_name = "${azurerm_resource_group.test-RG.name}"
  }
}

module "test-basiclinuxvm2" {
  source = "../."

  vm_depends_on                     = ["${module.test-basiclinuxvm.vm}"]
  name                              = "test2"
  resource_group_name               = "${azurerm_resource_group.test-RG.name}"
  admin_username                    = "azureadmin"
  secretPasswordName                = "${azurerm_key_vault_secret.serverPassword.name}"
  nic_subnetName                    = "${azurerm_subnet.subnet1.name}"
  nic_vnetName                      = "${azurerm_virtual_network.test-VNET.name}"
  nic_resource_group_name           = "${azurerm_resource_group.test-RG.name}"
  dnsServers                        = ["168.63.129.16"]
  nic_enable_ip_forwarding          = false
  nic_enable_accelerated_networking = false
  nic_ip_configuration = {
    private_ip_address            = "10.10.10.10"
    private_ip_address_allocation = "Static"
  }
  vm_size = "Standard_B1s"
  keyvault = {
    name                = "${azurerm_key_vault.test-keyvault.name}"
    resource_group_name = "${azurerm_resource_group.test-RG.name}"
  }
}
