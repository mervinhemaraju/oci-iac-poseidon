# Route Tables
resource "oci_core_route_table" "public_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "route-table-public-mgmt"

  # Route to the Internet gateway
  route_rules {

    network_entity_id = oci_core_internet_gateway.mgmt.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "route-table-private-mgmt"


  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.tool_server.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to mgmt compute tool_server"
      destination      = format("%s/32", route_rules.value["ip_address"])
      destination_type = "CIDR_BLOCK"
    }
  }

  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.app_server.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to mgmt compute app_server"
      destination      = format("%s/32", route_rules.value["ip_address"])
      destination_type = "CIDR_BLOCK"
    }
  }

  freeform_tags = local.tags.defaults
}


# Route Table Attachments
resource "oci_core_route_table_attachment" "public_mgmt" {
  subnet_id      = oci_core_subnet.public_mgmt.id
  route_table_id = oci_core_route_table.public_mgmt.id
}

resource "oci_core_route_table_attachment" "private_mgmt" {
  subnet_id      = oci_core_subnet.private_mgmt.id
  route_table_id = oci_core_route_table.private_mgmt.id
}
