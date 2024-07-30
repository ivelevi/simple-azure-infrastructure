resource "azurerm_public_ip" "web_lb" {
  name                = "web-lb-public-ip"
  resource_group_name = azurerm_resource_group.placeholder.name
  location            = azurerm_resource_group.placeholder.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "web_lb" {
  name                = "web-lb"
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "web-lb-front-end"
    public_ip_address_id = azurerm_public_ip.web_lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "web_lb_backend" {
  name            = "web-lb-backend-pool"
  loadbalancer_id = azurerm_lb.web_lb.id
}

resource "azurerm_lb_probe" "web_lb_probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.web_lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

resource "azurerm_lb_rule" "web_lb_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.web_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.web_lb_probe.id
}


resource "azurerm_network_interface_backend_address_pool_association" "web_lb_backend_association" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.web[count.index].id
  ip_configuration_name   = "web-nic-ip-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend.id

  depends_on = [
    azurerm_network_interface.web,
    azurerm_lb.web_lb
  ]
}