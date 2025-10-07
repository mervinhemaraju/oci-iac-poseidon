
output "vault_id" {
  description = "The OCID of the vault."
  value       = oci_kms_vault.this.id
}

output "kms_key_id" {
  description = "The OCID of the master encryption key in the vault."
  value       = oci_kms_key.this.id
}
