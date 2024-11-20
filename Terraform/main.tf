provider "azurerm" {
  features {}
  subscription_id = var.subscription_id  # Use variable for subscription ID
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  # Use variable for resource group name
  location = var.location  # Use variable for location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name  # Use variable for vnet name
  address_space       = var.vnet_address_space  # Use variable for address space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name  # Use variable for subnet name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes  # Use variable for subnet address prefixes
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name  # Use variable for NSG name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name  # Use variable for public IP name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags = {
    environment = "dev"
  }
}

# Network Interface for Linux VM
resource "azurerm_network_interface" "nic_linux" {
  name                = var.nic_name  # Use variable for NIC name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-linux-vm"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id  # Associate public IP
  }
}

# User Data Script (Base64 Encoded)
data "template_file" "user_data_script" {
  template = <<-EOT
    #!/bin/bash
    sudo dnf -y update
    # Install Docker
    sudo dnf config-manager --add-repo ${var.docker_repo_url}
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable --now docker
    sudo dnf install -y docker-compose-plugin
    docker compose version
    # Install Java 11 (OpenJDK)
    sudo dnf install -y java-${var.java_version}-openjdk-devel
    java -version
    # Install Maven
    sudo dnf install -y maven
    mvn -version
  EOT
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = "linux-vm-linux"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size  # Use variable for VM size
  admin_username                  = var.admin_username  # Use variable for admin username
  admin_password                  = var.admin_password  # Use variable for admin password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nic_linux.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_image_publisher  # Use variable for image publisher
    offer     = var.vm_image_offer  # Use variable for image offer
    sku       = var.vm_image_sku  # Use variable for image SKU
    version   = var.vm_image_version  # Use variable for image version
  }

  plan {
    name      = var.vm_image_sku  # Use variable for plan name
    publisher = var.vm_image_publisher  # Use variable for image publisher
    product   = var.vm_image_offer  # Use variable for product
  }

  custom_data = base64encode(data.template_file.user_data_script.rendered)

  admin_ssh_key {
    username   = var.admin_username  # Use variable for SSH username
    public_key = file(var.ssh_public_key_path)  # Use variable for SSH public key path
  }
}
