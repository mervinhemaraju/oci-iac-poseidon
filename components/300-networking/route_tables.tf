# Route Tables

resource "oci_core_route_table" "public_k8" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "route-table-public-k8"

  # Route to the Internet gateway
  route_rules {

    network_entity_id = oci_core_internet_gateway.mgmt.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_k8" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "route-table-private-k8"

  # Route to the NAT gateway
  route_rules {

    network_entity_id = oci_core_nat_gateway.mgmt.id

    description      = "Route to the NAT Gateway (Outbound Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "route-table-private-mgmt"


  # dynamic "route_rules" {
  #   for_each = data.oci_core_private_ips.k8s.private_ips
  #   content {

  #     network_entity_id = route_rules.value["id"]

  #     description      = "Route to K8 compute ${route_rules.value["display_name"]}"
  #     destination      = format("%s/32", route_rules.value["ip_address"])
  #     destination_type = "CIDR_BLOCK"
  #   }
  # }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_tool" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "route-table-private-tool"

  # Route to the NAT gateway
  route_rules {

    network_entity_id = oci_core_nat_gateway.mgmt.id

    description      = "Route to the NAT Gateway (Outbound Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

# Route Table Attachments
resource "oci_core_route_table_attachment" "public_k8" {
  subnet_id      = oci_core_subnet.public_k8.id
  route_table_id = oci_core_route_table.public_k8.id
}

resource "oci_core_route_table_attachment" "private_k8" {
  subnet_id      = oci_core_subnet.private_k8.id
  route_table_id = oci_core_route_table.private_k8.id
}

resource "oci_core_route_table_attachment" "private_mgmt" {
  subnet_id      = oci_core_subnet.private_mgmt.id
  route_table_id = oci_core_route_table.private_mgmt.id
}

resource "oci_core_route_table_attachment" "private_tool" {
  subnet_id      = oci_core_subnet.private_tool.id
  route_table_id = oci_core_route_table.private_tool.id
}
