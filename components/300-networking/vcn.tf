# The virtual cloud network for Mgmt and its attachments
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

# > The DRG attachment
resource "oci_core_drg_attachment" "mgmt_vcn" {

  drg_id = oci_core_drg.mgmt.id

  display_name = "mgmt-vcn-drg-attachment"

  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.mgmt.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
