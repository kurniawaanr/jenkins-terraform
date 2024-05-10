terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "./network"
}

module "virtual_machine" {
  source = "./virtualmachine"
}

output "virtual_machine_name" {
  value = module.virtual_machine.vm_name
}