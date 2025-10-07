# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Define our data source to fetch secrets
data "doppler_secrets" "apps_creds" {
  project = "apps-creds"
}
