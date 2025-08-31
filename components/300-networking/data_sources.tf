# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = local.secrets.oci
}
