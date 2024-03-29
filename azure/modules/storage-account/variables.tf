variable "location" {
    type = string
    description = "The location to setup resources"
}

variable "resource_group_name" {
    type = string
    description = "The name of the resource group under which to build this cluster"
}

variable "name" {
    type = string
    description = "Name of the cluster"
    default = ""
}

variable "prefix" {
    type = string
    description = "Naming Prefix"
    default = ""
}

variable tags {
    type = map(string)
    description = "List of tags to generate"
}

variable "subnet_id" {
    type = string
    description = "Id for the subnet"
}

variable "ip_rules" {
  type = list(string)
  description = "List of allowed IP addresses"
}

variable "azurefile_privatezone_name" {
  type = string
  description = "id for the azure file private zone"
  default = ""
}

variable "azurefile_privatezone_resource_group_name" {
  type = string
  description = "resource group for the azure file private zone"
  default = ""
}

variable "azurefile_privatezone_enabled" {
    type = bool
    description = "Whether to create the private zone records"
    default = false
}

variable "hub_subscription_id" {
  type = string
  description = "The ID of the hub subscription"
}

variable "key_vault_id" {
  type = string
  description = "The ID of the key vault to add the secret to"
}

variable "account_key_secret_name" {
  type = string
  description = "Name of the Secret to store the primary access key"
}

variable "account_name_secret_name" {
  type = string
  description = "Name of the Secret to store the storage account name"
}

variable "subscription_id" {
  type = string 
  description = "The subscription id to deploy this to"
}