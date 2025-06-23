resource "oci_kms_vault" "apps" {
  compartment_id = local.values.compartments.production
  display_name   = "vault/apps"
  vault_type     = "DEFAULT"

  freeform_tags = local.tags.defaults
}

# Create Master Encryption Key in the Vault
resource "oci_kms_key" "apps" {
  compartment_id = local.values.compartments.production
  display_name   = "kms/apps"

  key_shape {
    algorithm = "AES"
    length    = 32
  }

  management_endpoint = oci_kms_vault.apps.management_endpoint

  freeform_tags = local.tags.defaults
}
