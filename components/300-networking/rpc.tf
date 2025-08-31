# Create a remote peering connection
resource "oci_core_remote_peering_connection" "k8" {
  compartment_id = local.values.compartments.production
  drg_id         = oci_core_drg.k8.id

  display_name = "k8-rpc"
  # peer_id = oci_core_remote_peering_connection.test_remote_peering_connection2.id
  peer_region_name = var.region

  freeform_tags = local.tags.defaults
}
