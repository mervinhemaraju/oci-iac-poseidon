# Create a virtual cloud network for Database
resource "oci_core_vcn" "database" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.database
  ]

  display_name   = "database"
  dns_label      = "database"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# Create a private subnet for the database computes
resource "oci_core_subnet" "private_database" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_database
  vcn_id     = oci_core_vcn.database.id

  display_name               = "private-database"
  dns_label                  = "privatedatabase"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_default_security_list.default.id]

  route_table_id = oci_core_default_route_table.default.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.database
  ]
}

# Create a private subnet for the bastions
resource "oci_core_subnet" "private_mgmt" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_mgmt
  vcn_id     = oci_core_vcn.database.id

  display_name               = "private-mgmt"
  dns_label                  = "privatemgmt"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_default_security_list.default.id]

  route_table_id = oci_core_default_route_table.default.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.database
  ]
}
