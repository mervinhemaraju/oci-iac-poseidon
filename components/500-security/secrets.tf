# Add a secret to store vault details
resource "doppler_secret" "vaults" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_POSEIDON_VAULTS"
  value_type = "json"
  value = jsonencode(
    {
      "vault_ids" : {
        "application_uptimekuma" : module.vault_application_uptimekuma.vault_id,
        "application_cloudflare" : module.vault_application_cloudflare.vault_id
      }
    }
  )
}
