# terraform.tfvars

# Azure Subscription ID
subscription_id = "98fdc993-97aa-4299-96d2-450a8f05e135"

# Resource Group
resource_group_name = "rg-linux-vm1"

# Location for resources
location = "Canada Central"

# Virtual Network
vnet_name         = "vnet-linux-vm"
vnet_address_space = ["192.168.0.0/19"]

# Subnet
subnet_name            = "subnet-linux-vm"
subnet_address_prefixes = ["192.168.0.0/24"]

# Network Security Group
nsg_name = "nsg-linux-vm"

# Public IP
public_ip_name = "public-ip-linux-vm"

# Network Interface for VM
nic_name = "nic-linux-vm"

# VM Details
vm_size         = "Standard_DS1_v2"
admin_username  = "adminuser"
admin_password  = "Password@123" # Change this to a secure password
ssh_public_key_path = "~/.ssh/id_rsa.pub" # Path to your SSH public key

# Linux VM Image Details
vm_image_publisher = "solvedevops1643693563360"
vm_image_offer     = "rocky-linux-9"
vm_image_sku       = "plan001"
vm_image_version   = "latest"

# Docker installation details
docker_repo_url = "https://download.docker.com/linux/centos/docker-ce.repo"
java_version    = "11"
