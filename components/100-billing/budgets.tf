# Creates a zero spend budget
resource "oci_budget_budget" "oci_zero_spend_budget" {
  compartment_id = local.values.compartment.root
  amount         = 1
  reset_period   = "MONTHLY"

  description  = "A zero spend budget for OCI"
  display_name = "zero-spend-budget"
  target_type  = "COMPARTMENT"
  targets = [
    local.values.compartment.production
  ]

  freeform_tags = local.tags.defaults
}

resource "oci_budget_alert_rule" "oci_zsb_rule" {
  budget_id      = oci_budget_budget.oci_zero_spend_budget.id
  threshold      = 0.1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "0-strict-threshold"
  message      = <<EOF
  Minimum alert for the zero spend budget has been trigerred. 
  You have already spent 1 USD in the OCI Poseidon Account.
  Please take action ASAP if this was not intended.
  EOF
  recipients   = "mervinhemaraju16@gmail.com"

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_budget_budget.oci_zero_spend_budget
  ]
}
