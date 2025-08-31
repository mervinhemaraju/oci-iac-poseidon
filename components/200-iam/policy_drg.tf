
# Create a policy for VCN management as a acceptor
resource "oci_identity_policy" "acceptor_vcn_management" {

  compartment_id = local.values.compartments.root
  description    = "Allow the acceptor to manage VCN, RPC and DRG attachments in this tenancy"
  name           = "acceptor-vcn-management"
  statements = [
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "define group ${local.values.groups.gaia_groups.drg_admins.name} as ${local.values.groups.gaia_groups.drg_admins.id}",
    "define tenancy gaiaTenancy as ${local.values.compartments.root_gaia}",

    "endorse group ${local.values.groups.gaia_groups.drg_admins.name} to manage virtual-network-family in tenancy gaiaTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy gaiaTenancy",
    "admit group ${local.values.groups.gaia_groups.drg_admins.name} of tenancy gaiaTenancy to manage drg-attachment in tenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage drg in tenancy gaiaTenancy",
    "Admit group ${local.values.groups.gaia_groups.drg_admins.name} of tenancy gaiaTenancy to manage remote-peering-to in tenancy",
    "Allow group ${oci_identity_group.vcn_admins.name} to manage remote-peering-connections in tenancy",
    "Allow group ${oci_identity_group.vcn_admins.name} to manage drgs in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
