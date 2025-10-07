

# The Terraform Module
terraform {

  # Required providers
  required_providers {


    # OCI provider
    oci = {
      source  = "oracle/oci"
      version = "6.25.0"
    }
  }
}
