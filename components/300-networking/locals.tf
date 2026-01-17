
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-poseidon",
      "Environment" = "Production"
      "Component"   = "300-networking"
    }
  }

  secrets = {
    oci = "cloud-oci-creds"
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_COMPARTMENT_ROOT_ID
    }
  }

  networking = {

    cidr = {
      vcn = {
        mgmt = "10.15.0.0/16"
      }
      subnets = {
        public_k8           = "10.15.10.0/24"
        private_mgmt        = "10.15.20.0/24"
        private_k8_api      = "10.15.30.0/28"
        private_k8          = "10.15.31.0/24"
        private_db_gaia     = "10.18.20.0/24" # (This is found in the GAIA account)
        private_k8_zeus     = "10.17.31.0/24" # (This is found in the ZEUS account)
        private_k8_api_zeus = "10.17.30.0/28" # (This is found in the ZEUS account)
      }
    }
  }
}
