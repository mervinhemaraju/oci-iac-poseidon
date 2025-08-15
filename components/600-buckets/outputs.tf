

# The bucket namespace
output "bucket_namespace_certificates" {
  value = data.oci_objectstorage_namespace.this.namespace
}
