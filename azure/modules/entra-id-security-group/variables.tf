variable "environment_name" {
    type = string
    description = "The environment name for the App Registration Name"
}

variable "purpose" {
    type = string
    description = "Purpose of the App Registration"
}

variable "has_parent" {
  type = bool
  description = "This group has a parent group associated"
  default = false
}

variable "parent_group_object_id" {
  type = string
  description = "The object ID of the parent group"
  default = ""
}

variable "owners" {
  type = list(string)
  description = "A list of object ID's for users that will own (and therefore be able to manage) any Entra ID objects"
}