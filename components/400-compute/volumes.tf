# Static volume that will be used by K8 cluster
resource "oci_core_volume" "traefik_data" {
  compartment_id      = local.values.compartments.production
  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = "k8-apps-data-volumes"
  size_in_gbs  = 50

  freeform_tags = local.tags.defaults
}
