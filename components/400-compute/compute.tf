

# Create a compute instance for automation-server
resource "oci_core_instance" "automation_server" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.values.compute.name.automation_server

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
    vcpus         = 1
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.public_mgmt.subnets[0].id
    assign_public_ip       = true
    private_ip             = local.networking.ip_address.automation_server
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "80"
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

# Create a compute instance for tool-server
resource "oci_core_instance" "tool_server" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.values.compute.name.tool_server

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
    vcpus         = 1
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
    boot_volume_size_in_gbs = "60"
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

# Create a compute instance for app-server
resource "oci_core_instance" "app_server" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.values.compute.name.app_server

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
    vcpus         = 1
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.public_mgmt.subnets[0].id
    assign_public_ip       = true
    private_ip             = local.networking.ip_address.app_server
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "60"
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
