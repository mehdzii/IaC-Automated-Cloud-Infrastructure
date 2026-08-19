output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Nom du Resource Group créé"
}

output "location" {
  value       = azurerm_resource_group.rg.location
  description = "Région du Resource Group"
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "ID du sous-réseau applicatif"
}

output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "ID du groupe de sécurité réseau"
}
