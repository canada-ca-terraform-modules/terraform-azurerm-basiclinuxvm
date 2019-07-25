# Terraform Basic Virtual Machine

## Introduction

This module deploys a simple [virtual machine resource](https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/2019-03-01/virtualmachines) with an NSG, 1 NIC and a simple OS Disk.

## Security Controls

The following security controls can be met through configuration of this template:

* AC-1, AC-10, AC-11, AC-11(1), AC-12, AC-14, AC-16, AC-17, AC-18, AC-18(4), AC-2 , AC-2(5), AC-20(1) , AC-20(3), AC-20(4), AC-24(1), AC-24(11), AC-3, AC-3 , AC-3(1), AC-3(3), AC-3(9), AC-4, AC-4(14), AC-6, AC-6, AC-6(1), AC-6(10), AC-6(11), AC-7, AC-8, AC-8, AC-9, AC-9(1), AI-16, AU-2, AU-3, AU-3(1), AU-3(2), AU-4, AU-5, AU-5(3), AU-8(1), AU-9, CM-10, CM-11(2), CM-2(2), CM-2(4), CM-3, CM-3(1), CM-3(6), CM-5(1), CM-6, CM-6, CM-7, CM-7, IA-1, IA-2, IA-3, IA-4(1), IA-4(4), IA-5, IA-5, IA-5(1), IA-5(13), IA-5(1c), IA-5(6), IA-5(7), IA-9, SC-10, SC-13, SC-15, SC-18(4), SC-2, SC-2, SC-23, SC-28, SC-30(5), SC-5, SC-7, SC-7(10), SC-7(16), SC-7(8), SC-8, SC-8(1), SC-8(4), SI-14, SI-2(1), SI-3

## Dependancies

* [Resource Groups](https://github.com/canada-ca-azure-templates/resourcegroups/blob/master/readme.md)
* [Keyvault](https://github.com/canada-ca-azure-templates/keyvaults/blob/master/readme.md)
* [VNET-Subnet](https://github.com/canada-ca-azure-templates/vnet-subnet/blob/master/readme.md)

## Usage

```terraform
variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "tags" {
  default = {
    "Organizations"     = "PwP3-CCC-E&O"
    "Classification"    = "Unclassified"
    "Enviroment"        = "Sandbox"
    "CostCenter"        = "PwP3-EA"
    "Owner"             = "cloudteam@test.gc.ca"
  }
}

module "app1" {
  source = "github.com/canada-ca-terraform-modules/simplevm?ref=20190724.1"

  server = {
    name = "app1"
    resource_group_name = "PwS3-GCInterrop-Openshift-RG"
    admin_username      = "azureadmin"
    secretPasswordName  = "linuxDefaultPassword"
    nic = {
      subnetName          = "PwS3-Shared-PAZ-Openshift"
      vnetName            = "PwS3-Infra-NetShared-VNET"
      resource_group_name = "PwS3-Infra-NetShared-RG"
      enable_ip_forwarding          = false
      enable_accelerated_networking = false
      ip_configuration = {
        private_ip_address            = "10.250.21.198"
        private_ip_address_allocation = "Static"
      }
    }
    vm_size             = "Standard_D2_v3"
    storage_image_reference = {
      publisher = "RedHat",
      offer     = "RHEL",
      sku       = "7.4",
      version   = "latest"
    }
    storage_os_disk = {
      caching       = "ReadWrite"
      create_option = "FromImage"
      os_type      = "Linux"
      disk_size_gb = "64"
    }
  }
  keyvault = {
    name                = "PwS3-Infra-KV-simc2atbrf"
    resource_group_name = "PwS3-Infra-Keyvault-RG"
  }
}
```

## Parameter Values

TO BE DOCUMENTED

### Tag variable

| Name     | Type   | Required | Value      |
| -------- | ------ | -------- | ---------- |
| tagname1 | string | No       | tag1 value |
| ...      | ...    | ...      | ...        |
| tagnameX | string | No       | tagX value |

## History

| Date     | Release | Change     |
| -------- | ------- | ---------- |
| 20190724 |         | 1st deploy |
