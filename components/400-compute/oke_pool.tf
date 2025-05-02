# resource "oci_containerengine_node_pool" "test_node_pool" {
#   #Required
#   cluster_id     = oci_containerengine_cluster.test_cluster.id
#   compartment_id = var.compartment_id
#   name           = var.node_pool_name
#   node_shape     = var.node_pool_node_shape

#   #Optional
#   defined_tags  = { "Operations.CostCenter" = "42" }
#   freeform_tags = { "Department" = "Finance" }
#   initial_node_labels {

#     #Optional
#     key   = var.node_pool_initial_node_labels_key
#     value = var.node_pool_initial_node_labels_value
#   }
#   kubernetes_version = var.node_pool_kubernetes_version
#   node_config_details {
#     #Required
#     placement_configs {
#       #Required
#       availability_domain = var.node_pool_node_config_details_placement_configs_availability_domain
#       subnet_id           = oci_core_subnet.test_subnet.id

#       #Optional
#       capacity_reservation_id = oci_containerengine_capacity_reservation.test_capacity_reservation.id
#       fault_domains           = var.node_pool_node_config_details_placement_configs_fault_domains
#       preemptible_node_config {
#         #Required
#         preemption_action {
#           #Required
#           type = var.node_pool_node_config_details_placement_configs_preemptible_node_config_preemption_action_type

#           #Optional
#           is_preserve_boot_volume = var.node_pool_node_config_details_placement_configs_preemptible_node_config_preemption_action_is_preserve_boot_volume
#         }
#       }
#     }
#     size = var.node_pool_node_config_details_size

#     #Optional
#     is_pv_encryption_in_transit_enabled = var.node_pool_node_config_details_is_pv_encryption_in_transit_enabled
#     kms_key_id                          = oci_kms_key.test_key.id
#     node_pool_pod_network_option_details {
#       #Required
#       cni_type = var.node_pool_node_config_details_node_pool_pod_network_option_details_cni_type

#       #Optional
#       max_pods_per_node = var.node_pool_node_config_details_node_pool_pod_network_option_details_max_pods_per_node
#       pod_nsg_ids       = var.node_pool_node_config_details_node_pool_pod_network_option_details_pod_nsg_ids
#       pod_subnet_ids    = var.node_pool_node_config_details_node_pool_pod_network_option_details_pod_subnet_ids
#     }
#     defined_tags  = { "Operations.CostCenter" = "42" }
#     freeform_tags = { "Department" = "Finance" }
#     nsg_ids       = var.node_pool_node_config_details_nsg_ids
#   }
#   node_eviction_node_pool_settings {

#     #Optional
#     eviction_grace_duration              = var.node_pool_node_eviction_node_pool_settings_eviction_grace_duration
#     is_force_delete_after_grace_duration = var.node_pool_node_eviction_node_pool_settings_is_force_delete_after_grace_duration
#   }
#   node_image_name = oci_core_image.test_image.name
#   node_metadata   = var.node_pool_node_metadata
#   node_pool_cycling_details {

#     #Optional
#     is_node_cycling_enabled = var.node_pool_node_pool_cycling_details_is_node_cycling_enabled
#     maximum_surge           = var.node_pool_node_pool_cycling_details_maximum_surge
#     maximum_unavailable     = var.node_pool_node_pool_cycling_details_maximum_unavailable
#   }
#   node_shape_config {

#     #Optional
#     memory_in_gbs = var.node_pool_node_shape_config_memory_in_gbs
#     ocpus         = var.node_pool_node_shape_config_ocpus
#   }
#   node_source_details {
#     #Required
#     image_id    = oci_core_image.test_image.id
#     source_type = var.node_pool_node_source_details_source_type

#     #Optional
#     boot_volume_size_in_gbs = var.node_pool_node_source_details_boot_volume_size_in_gbs
#   }
#   quantity_per_subnet = var.node_pool_quantity_per_subnet
#   ssh_public_key      = var.node_pool_ssh_public_key
#   subnet_ids          = var.node_pool_subnet_ids
# }
