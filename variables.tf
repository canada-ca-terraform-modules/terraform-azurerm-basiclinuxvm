/*
List of option related variables:

custom_data = "some custom shell code to execute. Eg: ${file("serverconfig/jumpbox-init.sh")}"

monitoringAgent = {
  log_analytics_workspace_name = "somename"
  log_analytics_workspace_resource_group_name = "someRGName"
}

shutdownConfig = {
  autoShutdownStatus = "Enabled"
  autoShutdownTime = "17:00"
  autoShutdownTimeZone = "Eastern Standard Time"
  autoShutdownNotificationStatus = "Disabled"
}

Those can be set optionally if you want to deploy with optional features
*/

variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "tags" {
  description = "Tags that will be associated to VM resources"
  default = {
    "exampleTag1" = "SomeValue1"
    "exampleTag1" = "SomeValue2"
  }
}

variable "name" {
  description = "Name of the linux vm"
}

variable "data_disk_sizes_gb" {
  description = "List of data disk sizes in gigabytes required for the VM. EG.: If 3 data disks are required then data_disk_size_gb might look like [40,100,60] for disk 1 of 40 GB, disk 2 of 100 GB and disk 3 of 60 GB"
  default = []
}

variable "nic_subnetName" {
  description = "Name of the subnet to which the VM NIC will connect to"
}

variable "nic_vnetName" {
  description = "Name of the VNET the subnet is part of"
}
variable "nic_resource_group_name" {
  description = "Name of the resourcegroup containing the VNET"
}
variable "dnsServers" {
  description = "List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list"
  default     = null
}
variable "nic_enable_ip_forwarding" {
  description = "Enables IP Forwarding on the NIC."
  default     = false
}
variable "nic_enable_accelerated_networking" {
  description = "Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported."
  default     = false
}
variable "nic_ip_configuration" {
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address"
  default = {
    private_ip_address            = [null]
    private_ip_address_allocation = ["Dynamic"]
  }
}

variable "public_ip" {
  description = "Should the VM be assigned public IP(s). True or false."
  default     = false
}

variable "resource_group_name" {
  description = "Name of the resourcegroup that will contain the VM resources"
}

variable "admin_username" {
  description = "Name of the VM admin account"
}

variable "secretPasswordName" {
  description = "Name of the secret containing the VM admin account password"
}

variable "custom_data" {
  description = "Specifies custom data to supply to the machine. On Linux-based systems, this can be used as a cloud-init script. On other systems, this will be copied as a file on disk. Internally, Terraform will base64 encode this value before sending it to the API. The maximum length of the binary array is 65535 bytes."
  default     = null
}

variable "vm_size" {
  description = "Specifies the size of the Virtual Machine. Eg: Standard_F4"
}

variable "storage_image_reference" {
  description = "This block provisions the Virtual Machine from one of two sources: an Azure Platform Image (e.g. Ubuntu/Windows Server) or a Custom Image. Refer to https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html for more details."
  default = {
    publisher = "RedHat",
    offer     = "RHEL",
    sku       = "7.4",
    version   = "latest"
  }
}

variable "plan" {
  description = "An optional plan block"
  default = null
}

variable "storage_os_disk" {
  description = "This block describe the parameters for the OS disk. Refer to https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html for more details."
  default = {
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = null
    disk_size_gb  = null
  }
}

variable "keyvault" {
  description = "This block describe the keyvault resource name and resourcegroup name containing the keyvault"
  default = {
    name                = ""
    resource_group_name = ""
  }
}
