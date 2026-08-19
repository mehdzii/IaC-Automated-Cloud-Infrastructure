output "public_ip_addresses" {
  value       = azurerm_public_ip.public_ip[*].ip_address
  description = "Adresses IP publiques des machines virtuelles créées"
}

output "vm_ids" {
  value       = azurerm_linux_virtual_machine.vm[*].id
  description = "IDs des machines virtuelles"
}
