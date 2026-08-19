# Module Compute - Création des IPs Publiques, Interfaces Réseau et VMs Ubuntu

resource "azurerm_public_ip" "public_ip" {
  count               = var.vm_count
  name                = "pip-iac-${var.environment}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Stage-IaC-INPT"
  }
}

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "nic-iac-${var.environment}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "vm-iac-${var.environment}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Stage-IaC-INPT"
  }
}
