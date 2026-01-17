resource "oci_containerengine_node_pool" "default_pool" {
  cluster_id         = oci_containerengine_cluster.apps.id
  compartment_id     = local.values.compartments.production
  name               = "default-node-pool"
  node_shape         = local.values.compute.shape
  kubernetes_version = "v1.34.1"
  ssh_public_key     = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC

  initial_node_labels {
    key   = "role"
    value = "application"
  }

  initial_node_labels {
    key   = "node-pool"
    value = "default-pool"
  }

  node_config_details {

    size = 2

    placement_configs {
      availability_domain = data.oci_identity_availability_domain.this.name
      subnet_id           = data.oci_core_subnets.private_k8.subnets[0].id
    }

    node_pool_pod_network_option_details {
      cni_type       = "OCI_VCN_IP_NATIVE"
      pod_subnet_ids = data.oci_core_subnets.private_k8.subnets[*].id
    }

    freeform_tags = local.tags.defaults
  }

  node_eviction_node_pool_settings {
    eviction_grace_duration              = "PT1H" # 1 hour grace period
    is_force_delete_after_grace_duration = true
  }

  node_pool_cycling_details {
    is_node_cycling_enabled = true

    # Maximum surge during cycling - set to 0 to prevent exceeding 2 instances
    maximum_surge = "0"

    # Maximum unavailable during cycling - set to 1 to ensure at least 1 instance remains
    maximum_unavailable = "1"
  }

  node_shape_config {
    memory_in_gbs = 12
    ocpus         = 2
  }

  node_source_details {
    image_id                = local.values.compute.image_oke_node
    source_type             = "IMAGE"
    boot_volume_size_in_gbs = 50
  }

  freeform_tags = local.tags.defaults
}
