
output "uptimekuma_vault_id" {
  description = "The OCID of the vault for uptimekuma application secrets."
  value       = module.vault_application_uptimekuma.vault_id
}

output "cloudflare_vault_id" {
  description = "The OCID of the vault for cloudflare application secrets."
  value       = module.vault_application_cloudflare.vault_id
}
