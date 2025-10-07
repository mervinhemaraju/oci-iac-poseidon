# Create a vault for uptimekuma application secrets
module "vault_uptimekuma_application" {
  source = "module/vault"

  compartment_id = local.values.compartments.production
  vault_name     = "apps-uptimekuma"

  plaintext_secrets = {
    token        = "xxxx",
    anothertoken = "yyyy"
  }

  tags = local.tags.defaults
}
