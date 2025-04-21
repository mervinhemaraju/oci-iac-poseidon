# Create compute instances for the K8 nodes
resource "oci_core_instance" "k8_nodes" {

  for_each = local.values.compute.k8_nodes

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = each.value.name

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = each.value.memory
    ocpus         = each.value.ocpus
    # vcpus         = each.value.vcpus
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.private_k8.subnets[0].id
    assign_public_ip       = false
    private_ip             = each.value.ip_address
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = each.value.storage
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
    ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_POSEIDON_COMPUTE_KEY_PUBLIC
  }
}
