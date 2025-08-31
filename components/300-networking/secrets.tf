# Add a secret to store connection details
resource "doppler_secret" "k8_connection_details" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_POSEIDON_CONNECTIONS"
  value_type = "json"
  value = jsonencode(
    {
      "drg" : {
        "id" : oci_core_drg.drg.id
      },
      "rpc" : {
        "id" : oci_core_remote_peering_connection.k8.id
      }
    }
  )
}
