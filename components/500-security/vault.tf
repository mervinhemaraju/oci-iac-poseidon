# # Create a vault for uptimekuma application secrets
# module "vault_application_uptimekuma" {
#   source = "./modules/vault"

#   compartment_id = local.values.compartments.production
#   vault_name     = "application-uptimekuma"

#   secrets = {
#     admin_password = base64encode(data.doppler_secrets.apps_creds.map.UPTIMEKUMA_ADMIN_PASSWORD),
#   }

#   tags = local.tags.defaults
# }


# # Create a vault for cloudflare secrets
# module "vault_application_cloudflare" {
#   source = "./modules/vault"

#   compartment_id = local.values.compartments.production
#   vault_name     = "application-cloudflare"

#   secrets = {
#     admin_password = base64encode(data.doppler_secrets.apps_creds.map.CLOUDFLARE_TERRAFORM_TOKEN),
#   }

#   tags = local.tags.defaults
# }
