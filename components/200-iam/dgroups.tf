# Create a group for instance principal
resource "oci_identity_dynamic_group" "instance_principal" {
  compartment_id = local.values.compartments.root
  name           = local.values.groups.dynamic.instance_principal

  description   = "Dynamic group for instance principal"
  matching_rule = "ANY { instance.compartment.id = '${local.values.compartments.production}' }"

  freeform_tags = local.tags.defaults
}

# Creates a new user group for vcn admins
resource "oci_identity_group" "vcn_admins" {

  compartment_id = local.values.compartments.root
  name           = local.values.groups.vcn_admins
  description    = "VCN Admininistrators group."

  freeform_tags = local.tags.defaults
}

# > Creates a user group membership for each user in the administrators group
resource "oci_identity_user_group_membership" "vcn_admins" {
  for_each = {
    for membership in data.oci_identity_user_group_memberships.administrators.memberships :
    membership.user_id => membership
  }

  group_id = oci_identity_group.vcn_admins.id
  user_id  = each.key
}
