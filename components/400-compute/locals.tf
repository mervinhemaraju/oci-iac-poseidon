
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

      shape              = "VM.Standard.A1.Flex"
      image              = "ocid1.image.oc1.uk-london-1.aaaaaaaaskspfz56rlcmtfbr2milotcxqcpitly63zipmn4joygm44qs7hua"
      image_oci9_minimal = "ocid1.image.oc1.uk-london-1.aaaaaaaaey2ifzwcnwrgrfn4elbbnskg7vnge5udbslcdvp6qq22dqo5bv3a"

      k8_nodes = {
        automation_server = {
          name       = "automation-server"
          ip_address = "10.15.40.10"
          memory     = 6
          ocpus      = 2
          # vcpus      = 2
          storage = 40
        }
      }

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
