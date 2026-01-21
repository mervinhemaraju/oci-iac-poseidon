# Create a policy for VCN management as a acceptor
resource "oci_identity_policy" "helios_database_drg_statements" {

  compartment_id = local.values.compartments.root
  name           = "helios-database-drg-statements"
  description    = "Allows oci helios (requestor) to manage VCN, RPC and DRG attachments in this tenancy."

  statements = [
    # Definitions
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "define group ${local.values.groups.helios_groups.drg_admins.name} as ${local.values.groups.helios_groups.drg_admins.id}",
    "define tenancy heliosTenancy as ${local.values.compartments.root_helios}",

    # Endorse
    "endorse group ${local.values.groups.helios_groups.drg_admins.name} to manage virtual-network-family in tenancy heliosTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy heliosTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage drg in tenancy heliosTenancy",
    # Admit
    "admit group ${local.values.groups.helios_groups.drg_admins.name} of tenancy heliosTenancy to manage drg-attachment in tenancy",
    "admit group ${local.values.groups.helios_groups.drg_admins.name} of tenancy heliosTenancy to manage remote-peering-to in tenancy",
    # Allow
    "allow group ${oci_identity_group.vcn_admins.name} to manage remote-peering-connections in tenancy",
    "allow group ${oci_identity_group.vcn_admins.name} to manage drgs in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
