terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "ssh_public_key" {
  type        = string
  description = "Clé publique SSH pour les instances prod"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3... prod-key"
}

module "network" {
  source        = "../../modules/network"
  environment   = "prod"
  location      = "westeurope"
  subnet_prefix = "10.0.3.0/24"
}

module "compute" {
  source              = "../../modules/compute"
  environment         = "prod"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_id           = module.network.subnet_id
  vm_size             = "Standard_B2s"
  vm_count            = 2 # Haute disponibilité (HA) avec 2 VMs en Prod
  ssh_public_key      = var.ssh_public_key
}

output "prod_public_ips" {
  value       = module.compute.public_ip_addresses
  description = "IPs publiques des VMs Prod"
}
