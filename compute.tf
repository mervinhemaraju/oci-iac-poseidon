

# Create a compute instance for mongodb
resource "oci_core_instance" "mongo" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name
  # fault_domain        = data.oci_identity_fault_domains.this.fault_domains[0].name

  display_name = local.values.compute.mongo.name

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 24
    ocpus         = 4
    vcpus         = 4
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.public_database.id
    assign_public_ip       = false
    private_ip             = local.networking.ip_address.mongo
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "200"
    boot_volume_vpus_per_gb = 120
  }

  agent_config {
    dynamic "plugins_config" {
      for_each = local.values.compute.plugins_config
      content {
        desired_state = plugins_config.value.desired_state
        name          = plugins_config.value.name
      }
    }
  }

  freeform_tags = local.tags.defaults

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPUTE_KEY_PUBLIC
  }

}
