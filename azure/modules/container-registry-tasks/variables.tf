variable "container_registry_id" {
    type = string
    description = "ID of the container registry"
}

variable "user_assigned_identity_id" {
    type = string
    description = "ID of the user managed identity used"
}

variable "client_id" {
    type = string
    description = "Client ID of the user managed identity used"
}

variable "pat_token" {
    type = string
    description = "PAT TOKEN to use when talking to the repositories"
}

variable "branch_name" {
  type = string
  description = "The branch to follow on source control"
}

variable "login_server" {
  type = string
  description = "The FQDN of the ACR registry"
}