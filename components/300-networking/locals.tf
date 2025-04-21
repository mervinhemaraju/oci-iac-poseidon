
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

  values = {
    compartments = {
      production = data.doppler_secrets.prod_main.map.OCI_POSEIDON_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.prod_main.map.OCI_POSEIDON_COMPARTMENT_ROOT_ID
    }
  }

  networking = {

    cidr = {
      vcn = {
        mgmt = "10.15.0.0/16"
      }
      subnets = {
        private_mgmt = "10.15.10.0/24"
        private_k8   = "10.15.20.0/24"
        public_k8    = "10.15.30.0/24"
      }
    }
  }
}
