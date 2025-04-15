
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
      tool_server = "10.15.20.10"
      app_server  = "10.15.20.20"
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
        tool_server = "tool-server"
        app_server  = "app-server"
      }

      shape = "VM.Standard.E4.Flex"
      image = "ocid1.image.oc1.uk-london-1.aaaaaaaaztt4hboqemt4duojchd2uibe2tyeb5zmdax7kqs2uegtv3mpbn2q"

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
