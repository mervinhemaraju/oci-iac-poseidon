# Creates a zero spend budget
resource "oci_budget_budget" "zero_spend" {
  compartment_id = local.values.compartments.root
  amount         = 0
  reset_period   = "MONTHLY"

  description  = "A zero spend budget for OCI Poseidon"
  display_name = "budget-zero-spend"
  target_type  = "COMPARTMENT"
  targets = [
    local.values.compartments.production
  ]
}

# Create budget alerts for actual spend
resource "oci_budget_alert_rule" "zero_spend" {
  budget_id      = oci_budget_budget.zero_spend.id
  threshold      = 1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "zero-spend-threshold"
  message      = <<EOF
  Minimum alert for the zero spend budget has been trigerred. 
  You have already spent 1 USD in the OCI Poseidon Account.
  Please take action ASAP if this was not intended.
  EOF
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.zero_spend
  ]
}
