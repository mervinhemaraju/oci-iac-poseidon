
# Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_iac_cloud_main
}

# OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.doppler_secrets.prod_main.map.OCI_POSEIDON_TENANCY_OCID
  user_ocid    = data.doppler_secrets.prod_main.map.OCI_POSEIDON_USER_OCID
  fingerprint  = data.doppler_secrets.prod_main.map.OCI_POSEIDON_FINGERPRINT
  private_key  = data.doppler_secrets.prod_main.map.OCI_POSEIDON_PRIVATE_KEY
  region       = var.region
}

# The Terraform Module
terraform {

  # The required tf version
  required_version = "1.8.7"

  # Backend configuration
  backend "s3" {
    region = var.bucket_region
    key    = "${var.bucket_key_prefix_iac}/iam/state.tf"
    bucket = var.bucket_name
  }

  # Required providers
  required_providers {

    # Doppler provider
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.7.0"
    }

    # OCI provider
    oci = {
      source  = "oracle/oci"
      version = "6.25.0"
    }

    # AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}
