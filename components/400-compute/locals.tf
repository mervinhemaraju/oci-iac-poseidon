
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-poseidon",
      "Environment" = "Production"
      "Component"   = "400-compute"
    }
  }

  networking = {
    ip_address = {
      control_plane = "10.15.20.20"
    }
  }

  values = {

    compartments = {
      production = data.doppler_secrets.prod_main.map.OCI_POSEIDON_COMPARTMENT_PRODUCTION_ID
    }


    bastions = {
      "private-jump-01" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
      "private-jump-02" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
    }

    compute = {

      name = {
        control_plane = "control-plane"
      }

      shape = "VM.Standard.A1.Flex"
      image = "ocid1.image.oc1.uk-london-1.aaaaaaaasyryy6yl64a6sd4535q4uqyhueuaxfevvig3hp3357vslx3qev7q"

      k8_nodes = [
        {
          name       = "control_plane"
          ip_address = "10.15.20.20"
          memory     = 6
          ocpus      = 2
          vcpus      = 2
          storage    = 50
        },
        {
          name       = "worker-node-01"
          ip_address = "10.15.20.21"
          memory     = 9
          ocpus      = 1
          vcpus      = 2
          storage    = 75
        },
        {
          name       = "worker-node-02"
          ip_address = "10.15.20.22"
          memory     = 9
          ocpus      = 1
          vcpus      = 2
          storage    = 75
        },
      ]

      plugins_config = [
        {
          name          = "Bastion"
          desired_state = "ENABLED"
        },
        {
          name          = "OS Management Service Agent"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Run Command"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Monitoring"
          desired_state = "ENABLED"
        }
      ]
    }
  }

}
