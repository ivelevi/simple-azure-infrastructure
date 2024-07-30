provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "placeholder" {
  name     = "placeholder-testgp"
  location = "Australia East" #Used this region because of the free tier
}

resource "azurerm_virtual_network" "placeholder" {
  name                = "placeholder-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name
}

resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.placeholder.name
  virtual_network_name = azurerm_virtual_network.placeholder.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.placeholder.name
  virtual_network_name = azurerm_virtual_network.placeholder.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.placeholder.name
  virtual_network_name = azurerm_virtual_network.placeholder.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "web" {
  count               = 2
  name                = "web-nic-${count.index}"
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name

  ip_configuration {
    name                          = "web-nic-ip-config"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "web" {
  count                 = 2
  name                  = "web-vm-${count.index}"
  location              = azurerm_resource_group.placeholder.location
  resource_group_name   = azurerm_resource_group.placeholder.name
  network_interface_ids = [azurerm_network_interface.web[count.index].id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web-os-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "webvm${count.index}"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "web"
  }
}

resource "azurerm_network_interface" "app" {
  name                = "app-nic"
  location            = azurerm_resource_group.placeholder.location
  resource_group_name = azurerm_resource_group.placeholder.name

  ip_configuration {
    name                          = "app-nic-ip-config"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "app" {
  name                  = "app-vm"
  location              = azurerm_resource_group.placeholder.location
  resource_group_name   = azurerm_resource_group.placeholder.name
  network_interface_ids = [azurerm_network_interface.app.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "app-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "appvm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "app"
  }
}
