
# The OKE Cluster ID
output "oke_cluster_id" {
  value = oci_containerengine_cluster.apps.id
}

# Kubernetes version of the OKE Cluster
output "oke_cluster_kubernetes_version" {
  value = oci_containerengine_cluster.apps.kubernetes_version
}

# The OKE public endpoint
output "oke_cluster_public_endpoint" {
  value = oci_containerengine_cluster.apps.endpoint_config[0].public_endpoint
}

# The Node Pool ID
output "oke_node_pool_id" {
  value = oci_containerengine_node_pool.apps.id
}

# Kubernetes version of the OKE Node Pool
output "oke_node_pool_kubernetes_version" {
  value = oci_containerengine_node_pool.apps.kubernetes_version
}

# Nodes IDs
output "oke_node_pool_node_ids" {
  value = oci_containerengine_node_pool.apps.nodes[*].id
}

