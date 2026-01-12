# RPC for GAIA connection
resource "oci_core_remote_peering_connection" "gaia_database" {
  compartment_id = local.values.compartments.production
  drg_id         = oci_core_drg.k8.id

  display_name     = "rpc-gaia-database"
  peer_region_name = var.region

  freeform_tags = local.tags.defaults
}

# Add RPC for ZEUS connection
resource "oci_core_remote_peering_connection" "zeus_prod" {
  compartment_id = local.values.compartments.production
  drg_id         = oci_core_drg.k8.id

  display_name     = "rpc-zeus-prod"
  peer_region_name = "af-johannesburg-1" # ZEUS region

  freeform_tags = local.tags.defaults
}
