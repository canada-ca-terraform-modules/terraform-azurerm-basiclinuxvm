variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "tags" {
  default = {
    "Organizations"     = "PwP0-CCC-E&O"
    "DeploymentVersion" = "2018-12-14-01"
    "Classification"    = "Unclassified"
    "Enviroment"        = "Sandbox"
    "CostCenter"        = "PwP0-EA"
    "Owner"             = "cloudteam@tpsgc-pwgsc.gc.ca"
  }
}

variable "server" {
  default = {
    name = "test"
    nic = {
      subnetName          = "PwS3-Shared-PAZ-Openshift-RG"
      vnetName            = "PwS3-Infra-NetShared-VNET"
      resource_group_name = "PwS3-Infra-NetShared-RG"
    }
    resource_group_name = "PwS3-GCInterrop-Openshift"
    admin_username      = "azureadmin"
    secretPasswordName  = "linuxDefaultPassword"
    vm_size             = "Standard_F4"
    ip_configuration = {
      private_ip_address            = "null"
      private_ip_address_allocation = "Dynamic"
    }
    storage_image_reference = {
      publisher = "RedHat",
      offer     = "RHEL",
      sku       = "7.4",
      version   = "latest"
    }
    storage_os_disk = {
      caching       = "ReadWrite"
      create_option = "FromImage"
      os_type       = "Linux"
      disk_size_gb  = "32"
    }
  }
}

variable "keyvault" {
  default = {
    name                = "PwS3-Infra-KV-simc2atbrf"
    resource_group_name = "PwS3-Infra-Keyvault-RG"
  }
}
