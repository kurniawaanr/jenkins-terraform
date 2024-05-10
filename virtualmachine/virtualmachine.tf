module "network" {
  source = "../network"
}

resource "azurerm_resource_group" "jenkins-rg" {
  name     = "jenkins-resources"
  location = "southeastasia"
  tags = {
    environtment = "dev"
  }
}

resource "azurerm_linux_virtual_machine" "jenkins-vm" {
  name                = "jenkins-machine"
  resource_group_name = azurerm_resource_group.jenkins-rg.name
  location            = azurerm_resource_group.jenkins-rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    module.network.network_interface_id,
  ]

  custom_data = filebase64("customdata-jenkins.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azurejenkinskey.pub")
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
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.jenkins-vm.name
}
