# vars.tf

# Subscription ID for the Azure provider
variable "subscription_id" {
  description = "The Azure subscription ID to use"
  type        = string
}

# Resource Group Name
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

# Location for resources (e.g., "Canada Central")
variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

# Virtual Network Name
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

# Address Space for Virtual Network
variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

# Subnet Name
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

# Subnet Address Prefixes
variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

# Network Security Group Name
variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

# Public IP Name
variable "public_ip_name" {
  description = "The name of the public IP address"
  type        = string
}

# Virtual Machine Network Interface Name
variable "nic_name" {
  description = "The name of the network interface for the Linux VM"
  type        = string
}

# Virtual Machine Size (e.g., Standard_DS1_v2)
variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

# Admin username for the Linux VM
variable "admin_username" {
  description = "The admin username for the Linux VM"
  type        = string
}

# Admin password for the Linux VM
variable "admin_password" {
  description = "The admin password for the Linux VM"
  type        = string
}

# SSH Public Key for authentication
variable "ssh_public_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}

# Linux VM Image Details
variable "vm_image_publisher" {
  description = "The publisher of the Linux VM image"
  type        = string
}

variable "vm_image_offer" {
  description = "The offer for the Linux VM image"
  type        = string
}

variable "vm_image_sku" {
  description = "The SKU for the Linux VM image"
  type        = string
}

variable "vm_image_version" {
  description = "The version of the Linux VM image"
  type        = string
}

# Docker installation script details
variable "docker_repo_url" {
  description = "The Docker repository URL"
  type        = string
}

variable "java_version" {
  description = "The version of Java to install"
  type        = string
}
