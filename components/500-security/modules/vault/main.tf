# Create the vault
resource "oci_kms_vault" "this" {
  compartment_id = var.compartment_id
  display_name   = var.vault_name
  vault_type     = "DEFAULT"

  freeform_tags = var.tags
}

# Create Master Encryption Key in the Vault
resource "oci_kms_key" "this" {
  compartment_id = var.compartment_id
  display_name   = var.vault_name

  key_shape {
    algorithm = "AES"
    length    = 32
  }

  management_endpoint = oci_kms_vault.this.management_endpoint

  freeform_tags = var.tags
}


# Create one secret for each entry in the var.plaintext_secrets map
resource "oci_vault_secret" "this_plaintext" {

  for_each = var.plaintext_secrets

  # Required arguments that are the same for all secrets
  compartment_id = var.compartment_id
  key_id         = oci_kms_key.this.id
  vault_id       = oci_kms_vault.this.id

  secret_name = each.key

  description = "Secret for '${each.key}' that is managed by Terraform."

  secret_content {
    content_type = "PLAINTEXT"
    content      = each.value
  }

  # Other arguments
  enable_auto_generation = false
  freeform_tags          = var.tags
}
