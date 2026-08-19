variable "environment" {
  type        = string
  description = "Nom de l'environnement (dev, staging, prod)"
}

variable "location" {
  type        = string
  description = "Région Cloud (ex: West Europe, France Central, us-east-1)"
  default     = "westeurope"
}

variable "address_space" {
  type        = list(string)
  description = "Plage d'adresses du réseau virtuel (VNet/VPC)"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  type        = string
  description = "Préfixe CIDR du sous-réseau applicatif"
  default     = "10.0.1.0/24"
}

variable "allowed_ssh_ips" {
  type        = list(string)
  description = "Adresses IP autorisées pour l'accès SSH"
  default     = ["0.0.0.0/0"]
}
