/*
Example:

diskEncrypt = true

*/

variable "encryptDisks" {
  description = "Should the VM disks be encrypted"
  default     = false
}

resource "random_uuid" "SequenceVersion" { }

resource "azurerm_virtual_machine_extension" "AzureDiskEncryption" {

  count                      = "${var.encryptDisks == false ? 0 : 1}"
  name                       = "AzureDiskEncryption"
  location                   = "${var.location}"
  resource_group_name        = "${var.resource_group_name}"
  virtual_machine_name       = "${azurerm_virtual_machine.VM.name}"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryptionForLinux"
  type_handler_version       = "1.1"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
        {  
          "EncryptionOperation": "EnableEncryption",
          "KeyVaultResourceId": "${data.azurerm_key_vault.keyvaultsecrets.id}",
          "KeyVaultURL": "${data.azurerm_key_vault.keyvaultsecrets.vault_uri}",
          "KeyEncryptionAlgorithm": "",
          "VolumeType": "All",
          "ResizeOSDisk": false,
          "SequenceVersion": "${random_uuid.SequenceVersion.result}"
        }
  SETTINGS

  tags = "${var.tags}"
}
