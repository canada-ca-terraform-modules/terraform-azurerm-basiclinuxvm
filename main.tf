resource azurerm_network_security_group NSG {
  name                = "${var.server.name}-NSG"
  location            = "${var.location}"
  resource_group_name = "${var.server.resource_group_name}"
  security_rule {
    name                       = "AllowAllInbound"
    description                = "Allow all in"
    access                     = "Allow"
    priority                   = "100"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllOutbound"
    description                = "Allow all out"
    access                     = "Allow"
    priority                   = "105"
    protocol                   = "*"
    direction                  = "Outbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  tags = "${var.tags}"
}

resource azurerm_network_interface NIC {
  name                          = "${var.server.name}-Nic1"
  location                      = "${var.location}"
  resource_group_name           = "${var.server.resource_group_name}"
  enable_ip_forwarding          = "${var.server.nic.enable_ip_forwarding}"
  enable_accelerated_networking = "${var.server.nic.enable_accelerated_networking}"
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address            = "${var.server.nic.ip_configuration.private_ip_address}"
    private_ip_address_allocation = "${var.server.nic.ip_configuration.private_ip_address_allocation}"
    primary                       = true
  }
}

resource azurerm_virtual_machine mastervm {
  name                             = "${var.server.name}"
  location                         = "${var.location}"
  resource_group_name              = "${var.server.resource_group_name}"
  vm_size                          = "${var.server.vm_size}"
  network_interface_ids            = ["${azurerm_network_interface.NIC.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.NIC.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${var.server.name}"
    admin_username = "${var.server.admin_username}"
    admin_password = "${data.azurerm_key_vault_secret.secretPassword.value}"
  }
  storage_image_reference {
    publisher = "${var.server.storage_image_reference.publisher}"
    offer     = "${var.server.storage_image_reference.offer}"
    sku       = "${var.server.storage_image_reference.sku}"
    version   = "${var.server.storage_image_reference.version}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name          = "${var.server.name}-OsDisk_1"
    caching       = "${var.server.storage_os_disk.caching}"
    create_option = "${var.server.storage_os_disk.create_option}"
    os_type       = "${var.server.storage_os_disk.os_type}"
    disk_size_gb  = "${var.server.storage_os_disk.disk_size_gb}"
  }
  tags = "${var.tags}"
}
