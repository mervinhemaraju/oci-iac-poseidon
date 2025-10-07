
variable "compartment_id" {
  description = "The compartment id where the vault should be created"
  type        = string
}

variable "vault_name" {
  description = "The name of the vault"
  type        = string
}

variable "secrets" {
  description = "A map of secrets to create. The key will be used as the secret_name and the value will be the secret's content (in BASE64)."
  type        = map(string)
  default     = {}
}


variable "tags" {
  description = "A map of tags to apply to the resources"
  type        = map(string)
  default     = {}
}
