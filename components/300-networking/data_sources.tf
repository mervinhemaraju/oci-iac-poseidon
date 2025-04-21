# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Get ths private ips for computes
data "oci_core_private_ips" "k8s" {
  subnet_id = oci_core_subnet.public_k8.id

  depends_on = [
    oci_core_subnet.private_k8
  ]
}
