

# The bucket namespace
output "bucket_namespace_certificates" {
  value = data.oci_objectstorage_namespace.this.namespace
}

# The certificates bucket ID
output "bucket_id_certificates" {
  value = oci_objectstorage_bucket.certificates.bucket_id
}
