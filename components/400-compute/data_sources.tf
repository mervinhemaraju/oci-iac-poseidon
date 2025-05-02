# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

data "oci_core_vcns" "mgmt" {
  compartment_id = local.values.compartments.production

  display_name = "mgmt"
}

data "oci_core_subnets" "private_k8" {
  compartment_id = local.values.compartments.production
  display_name   = "private-k8"
  vcn_id         = data.oci_core_vcns.mgmt.virtual_networks[0].id
}

data "oci_core_subnets" "private_tool" {
  compartment_id = local.values.compartments.production
  display_name   = "private-tool"
  vcn_id         = data.oci_core_vcns.mgmt.virtual_networks[0].id
}

data "oci_core_subnets" "private_mgmt" {
  compartment_id = local.values.compartments.production
  display_name   = "private-mgmt"
  vcn_id         = data.oci_core_vcns.mgmt.virtual_networks[0].id
}
