resource "oci_identity_policy" "zeus_database_drg_statements" {

  compartment_id = local.values.compartments.root
  name           = "zeus-database-drg-statements"
  description    = "Allows oci zeus (requestor) to manage VCN, RPC and DRG attachments in this tenancy."

  statements = [
    # Definitions
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "define group ${local.values.groups.zeus_groups.drg_admins.name} as ${local.values.groups.zeus_groups.drg_admins.id}",
    "define tenancy zeusTenancy as ${local.values.compartments.root_zeus}",

    # Endorse - POSEIDON endorses its own group
    "endorse group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage drg in tenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage remote-peering-connections in tenancy",

    # Admit - Accept ZEUS group to manage connections
    "admit group ${local.values.groups.zeus_groups.drg_admins.name} of tenancy zeusTenancy to manage drg-attachment in tenancy",
    "admit group ${local.values.groups.zeus_groups.drg_admins.name} of tenancy zeusTenancy to manage remote-peering-to in tenancy",

    # Allow - POSEIDON's vcn_admins to manage its own resources
    "allow group ${oci_identity_group.vcn_admins.name} to manage remote-peering-connections in tenancy",
    "allow group ${oci_identity_group.vcn_admins.name} to manage drgs in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
