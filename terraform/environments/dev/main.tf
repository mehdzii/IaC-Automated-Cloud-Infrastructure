terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }

  # Pour la démo initiale, backend local. Pour la production, décommenter le backend distant.
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "sttfstatedev"
  #   container_name       = "tfstate"
  #   key                  = "dev.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

variable "ssh_public_key" {
  type        = string
  description = "Clé publique SSH pour les instances dev"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3... dev-key"
}

module "network" {
  source        = "../../modules/network"
  environment   = "dev"
  location      = "westeurope"
  subnet_prefix = "10.0.1.0/24"
}

module "compute" {
  source              = "../../modules/compute"
  environment         = "dev"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_id           = module.network.subnet_id
  vm_size             = "Standard_B1s"
  vm_count            = 1
  ssh_public_key      = var.ssh_public_key
}

output "dev_public_ip" {
  value       = module.compute.public_ip_addresses
  description = "IP publique de la VM Dev"
}
