# Module Network - Définition Réseau Virtual & Security Group

resource "azurerm_resource_group" "rg" {
  name     = "rg-iac-${var.environment}"
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Stage-IaC-INPT"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-iac-${var.environment}"
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-iac-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-iac-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Règle SSH
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ssh_ips[0]
    destination_address_prefix = "*"
  }

  # Règle Application FastAPI (Port 8000)
  security_rule {
    name                       = "Allow-FastAPI"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Règle Prometheus (Port 9090)
  security_rule {
    name                       = "Allow-Prometheus"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9090"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Règle Grafana (Port 3000)
  security_rule {
    name                       = "Allow-Grafana"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
