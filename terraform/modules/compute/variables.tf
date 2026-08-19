variable "environment" {
  type        = string
  description = "Nom de l'environnement (dev, staging, prod)"
}

variable "resource_group_name" {
  type        = string
  description = "Nom du Resource Group parent"
}

variable "location" {
  type        = string
  description = "Région Cloud"
}

variable "subnet_id" {
  type        = string
  description = "ID du sous-réseau où attacher la VM"
}

variable "vm_size" {
  type        = string
  description = "Taille de la VM (ex: Standard_B1s, Standard_B2s)"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Nom d'utilisateur administrateur Linux"
  default     = "ubuntu"
}

variable "ssh_public_key" {
  type        = string
  description = "Contenu de la clé publique SSH pour l'accès administrateur"
}

variable "vm_count" {
  type        = number
  description = "Nombre de VMs à déployer"
  default     = 1
}
