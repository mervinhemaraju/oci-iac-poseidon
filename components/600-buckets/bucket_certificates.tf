resource "oci_objectstorage_bucket" "certificates" {
  compartment_id = local.values.compartments.production
  name           = "certificates"
  namespace      = data.oci_objectstorage_namespace.this.namespace

  storage_tier = "Standard"
  access_type  = "NoPublicAccess"
  versioning   = "Disabled"
  # auto_tiering = var.bucket_auto_tiering
  # kms_key_id = oci_kms_key.test_key.id
  # metadata = var.bucket_metadata
  # object_events_enabled = var.bucket_object_events_enabled
  # retention_rules {
  #     display_name = var.retention_rule_display_name
  #     duration {
  #         #Required
  #         time_amount = var.retention_rule_duration_time_amount
  #         time_unit = var.retention_rule_duration_time_unit
  #     }
  #     time_rule_locked = var.retention_rule_time_rule_locked
  # }

  freeform_tags = local.tags.defaults
}
