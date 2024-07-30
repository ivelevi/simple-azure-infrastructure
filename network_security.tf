resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name
}

# SG rules are opened just to ilustrate, this is a bad practice, we should open only what we will use 
# NSG rules for web subnet
resource "azurerm_network_security_rule" "web_nsg_inbound" {
  name                        = "web-nsg-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.1.0/24"
  resource_group_name         = azurerm_resource_group.placeholder.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

# NSG rules for app subnet
resource "azurerm_network_security_rule" "app_nsg_inbound" {
  name                        = "app-nsg-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.2.0/24"
  resource_group_name         = azurerm_resource_group.placeholder.name
  network_security_group_name = azurerm_network_security_group.app_nsg.name
}

# NSG rules for db subnet
resource "azurerm_network_security_rule" "db_nsg_inbound" {
  name                        = "db-nsg-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.3.0/24"
  resource_group_name         = azurerm_resource_group.placeholder.name
  network_security_group_name = azurerm_network_security_group.db_nsg.name
}

# NSG rules for outbound traffic (allow all)
resource "azurerm_network_security_rule" "web_nsg_outbound" {
  name                        = "web-nsg-outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.placeholder.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

resource "azurerm_network_security_rule" "app_nsg_outbound" {
  name                        = "app-nsg-outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.2.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.placeholder.name
  network_security_group_name = azurerm_network_security_group.app_nsg.name
}

resource "azurerm_network_security_rule" "db_nsg_outbound" {
  name                        = "db-nsg-outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.3.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.placeholder.name
  network_security_group_name = azurerm_network_security_group.db_nsg.name
}

# Associating NSGs with subnets
resource "azurerm_subnet_network_security_group_association" "web_nsg_association" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "app_nsg_association" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db_nsg_association" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}
