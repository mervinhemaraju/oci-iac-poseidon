resource "oci_containerengine_node_pool" "test_node_pool" {
  cluster_id         = oci_containerengine_cluster.apps.id
  compartment_id     = local.values.compartments.production
  name               = "apps-pool"
  node_shape         = local.values.compute.shape
  kubernetes_version = "v1.32.1"

  #   quantity_per_subnet = var.node_pool_quantity_per_subnet
  ssh_public_key = data.doppler_secrets.prod_main.map.OCI_POSEIDON_COMPUTE_KEY_PUBLIC
  #   subnet_ids          = var.node_pool_subnet_ids

  #   initial_node_labels {

  #     #Optional
  #     key   = var.node_pool_initial_node_labels_key
  #     value = var.node_pool_initial_node_labels_value
  #   }
  node_config_details {
    size = 2
    placement_configs {
      availability_domain = data.oci_identity_availability_domain.this.name
      subnet_id           = data.oci_core_subnets.private_k8.subnets[0].id

      #   capacity_reservation_id = oci_containerengine_capacity_reservation.test_capacity_reservation.id
      #   fault_domains           = var.node_pool_node_config_details_placement_configs_fault_domains

    }

    # node_pool_pod_network_option_details {
    #   #Required
    #   cni_type = var.node_pool_node_config_details_node_pool_pod_network_option_details_cni_type

    #   #Optional
    #   max_pods_per_node = var.node_pool_node_config_details_node_pool_pod_network_option_details_max_pods_per_node
    #   pod_nsg_ids       = var.node_pool_node_config_details_node_pool_pod_network_option_details_pod_nsg_ids
    #   pod_subnet_ids    = var.node_pool_node_config_details_node_pool_pod_network_option_details_pod_subnet_ids
    # }

    freeform_tags = local.tags.defaults
  }

  #   node_eviction_node_pool_settings {

  #     #Optional
  #     eviction_grace_duration              = var.node_pool_node_eviction_node_pool_settings_eviction_grace_duration
  #     is_force_delete_after_grace_duration = var.node_pool_node_eviction_node_pool_settings_is_force_delete_after_grace_duration
  #   }

  #   node_pool_cycling_details {

  #     #Optional
  #     is_node_cycling_enabled = var.node_pool_node_pool_cycling_details_is_node_cycling_enabled
  #     maximum_surge           = var.node_pool_node_pool_cycling_details_maximum_surge
  #     maximum_unavailable     = var.node_pool_node_pool_cycling_details_maximum_unavailable
  #   }

  node_shape_config {
    memory_in_gbs = 9
    ocpus         = 1
  }

  node_source_details {
    image_id    = "ocid1.image.oc1.uk-london-1.aaaaaaaaw5wosv5hcnsccntpobqcflm4viraldidrnlafrozu6q6izkswmma"
    source_type = "IMAGE"

    boot_volume_size_in_gbs = 75
  }

  freeform_tags = local.tags.defaults
}
