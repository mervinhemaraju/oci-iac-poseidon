# Create a compute instance for the control plane
resource "oci_core_instance" "control_plane" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.values.compute.name.control_plane

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 6
    ocpus         = 2
    vcpus         = 2
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.public_mgmt.subnets[0].id
    assign_public_ip       = true
    private_ip             = local.networking.ip_address.tool_server
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "50"
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

# Create compute instances for the worker nodes
resource "oci_core_instance" "worker_nodes" {

  for_each = local.values.compute.worker_nodes

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = each.value.name

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = each.value.memory
    ocpus         = each.value.ocpus
    vcpus         = each.value.vcpus
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.public_mgmt.subnets[0].id
    assign_public_ip       = true
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
