# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = local.secrets.oci
}

# Define our data source to fetch secrets
data "doppler_secrets" "apps_creds" {
  project = local.secrets.apps
}
