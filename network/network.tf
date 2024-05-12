resource "azurerm_resource_group" "jenkins-rg" {
  name     = "jenkins-resources"
  location = "southeastasia"
  tags = {
    environtment = "dev"
  }
}



resource "azurerm_virtual_network" "jenkins-vn" {
  name                = "jenkins-network"
  resource_group_name = azurerm_resource_group.jenkins-rg.name
  location            = azurerm_resource_group.jenkins-rg.location
  address_space       = ["10.0.0.0/24"]

  tags = {
    environtment = "dev"
  }
}

resource "azurerm_subnet" "jenkins-subnet" {
  name                 = "jenkins-subnet"
  resource_group_name  = azurerm_resource_group.jenkins-rg.name
  virtual_network_name = azurerm_virtual_network.jenkins-vn.name
  address_prefixes     = ["10.0.0.0/25"]
}

resource "azurerm_network_security_group" "jenkins-sg" {
  name                = "jenkins-sg"
  location            = azurerm_resource_group.jenkins-rg.location
  resource_group_name = azurerm_resource_group.jenkins-rg.name

  tags = {
    environtment = "dev"
  }
}

resource "azurerm_network_security_rule" "jenkins-dev-rule" {
  name                        = "jenkins-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.jenkins-rg.name
  network_security_group_name = azurerm_network_security_group.jenkins-sg.name
}

resource "azurerm_subnet_network_security_group_association" "jenkins-sga" {
  subnet_id                 = azurerm_subnet.jenkins-subnet.id
  network_security_group_id = azurerm_network_security_group.jenkins-sg.id
}

resource "azurerm_public_ip" "jenkins-ip" {
  name                = "jenkins-ip"
  resource_group_name = azurerm_resource_group.jenkins-rg.name
  location            = azurerm_resource_group.jenkins-rg.location
  allocation_method   = "Dynamic"

  tags = {
    environtment = "dev"
  }
}

resource "azurerm_network_interface" "jenkins-nic" {
  name                = "jenkins-nic"
  location            = azurerm_resource_group.jenkins-rg.location
  resource_group_name = azurerm_resource_group.jenkins-rg.name

  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.jenkins-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jenkins-ip.id
  }

  tags = {
    environtment = "dev"
  }
}

output "network_interface_id" {
  value = azurerm_network_interface.jenkins-nic.id
}
