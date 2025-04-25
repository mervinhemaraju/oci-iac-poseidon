# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

data "oci_objectstorage_namespace" "this" {
  compartment_id = local.values.compartments.production
}
