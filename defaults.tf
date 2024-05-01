# The default resources that comes with a VCN
resource "oci_core_default_security_list" "default" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.database.default_security_list_id

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all traffic from all sources"

  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from all sources"
  }
}

resource "oci_core_default_route_table" "default" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.database.default_route_table_id
}
