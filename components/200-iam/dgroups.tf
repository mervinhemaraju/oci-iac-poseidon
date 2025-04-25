
resource "oci_identity_dynamic_group" "instance_principal" {
  compartment_id = local.values.compartments.root
  name           = local.values.groups.dynamic.instance_principal

  description   = "Dynamic group for instance principal"
  matching_rule = "ALL {resource.type = 'instance'}"

  freeform_tags = local.tags.defaults
}
