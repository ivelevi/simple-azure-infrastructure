resource "azurerm_sql_server" "placeholder" {
  name                         = ""
  resource_group_name          = azurerm_resource_group.placeholder.name
  location                     = azurerm_resource_group.placeholder.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = ""  
}

resource "azurerm_sql_database" "placeholder" {
  name                = ""
  resource_group_name = azurerm_resource_group.placeholder.name
  location            = azurerm_resource_group.placeholder.location
  server_name         = azurerm_sql_server.placeholder.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1  
}

resource "azurerm_sql_firewall_rule" "placeholder" {
  name                = ""
  resource_group_name = azurerm_resource_group.placeholder.name
  server_name         = azurerm_sql_server.placeholder.name
  start_ip_address    = "0.0.0.0"  
  end_ip_address      = "255.255.255.255"
}
