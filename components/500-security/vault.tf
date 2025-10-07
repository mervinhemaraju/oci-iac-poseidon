# Create a vault for uptimekuma application secrets
module "vault_uptimekuma_application" {
  source = "./modules/vault"

  compartment_id = local.values.compartments.production
  vault_name     = "apps-uptimekuma"

  secrets = {
    token        = base64encode("xxxx"),
    anothertoken = base64encode("yyyy")
  }

  tags = local.tags.defaults
}
