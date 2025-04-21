# Create a virtual cloud network for Mgmt
resource "oci_core_vcn" "mgmt" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.mgmt
  ]

  display_name   = "mgmt"
  dns_label      = "mgmt"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# Create a private subnet for the kubernetes cluster
resource "oci_core_subnet" "private_k8" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_k8
  vcn_id     = oci_core_vcn.mgmt.id

  display_name               = "private-k8"
  dns_label                  = "privatek8"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_k8.id]

  route_table_id = oci_core_route_table.private_k8.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.mgmt
  ]
}


# Create a private subnet for the mgmt resources
resource "oci_core_subnet" "private_mgmt" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_mgmt
  vcn_id     = oci_core_vcn.mgmt.id

  display_name               = "private-mgmt"
  dns_label                  = "privatemgmt"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_mgmt.id]

  route_table_id = oci_core_route_table.private_mgmt.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.mgmt
  ]
}

